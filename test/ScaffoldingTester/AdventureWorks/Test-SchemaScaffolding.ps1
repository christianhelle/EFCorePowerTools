<#
.SYNOPSIS
    Verifies that the efcpt "schemas" option scaffolds exactly the objects in the selected schemas.

.DESCRIPTION
    Builds the AdventureWorks dacpac and the efcpt (EF Core 8) CLI from source, then scaffolds the
    dacpac once per scenario. Each scenario selects two or three schemas, and the tables, views,
    stored procedures and functions found in the generated code must match the expected objects
    for those schemas exactly.

.EXAMPLE
    pwsh ./Test-SchemaScaffolding.ps1

.EXAMPLE
    pwsh ./Test-SchemaScaffolding.ps1 -SkipBuild -KeepOutput
#>
[CmdletBinding()]
param(
    # Use the existing dacpac and efcpt build output.
    [switch] $SkipBuild,

    # Keep the generated code in the temp folder for inspection.
    [switch] $KeepOutput
)

$ErrorActionPreference = 'Stop'

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '../../..')).Path
$sqlProject = Join-Path $PSScriptRoot 'ErikEJ.Dacpac.AdventureWorks.csproj'
$dacpac = Join-Path $PSScriptRoot 'bin/Debug/netstandard2.1/ErikEJ.Dacpac.AdventureWorks.dacpac'
$efcptProject = Join-Path $repoRoot 'src/Core/efcpt.8/efcpt.8.csproj'
$efcpt = Join-Path $repoRoot 'src/Core/efcpt.8/bin/Debug/net8.0/efcpt.8.dll'

# Every object in the AdventureWorks dacpac, by schema.
$database = @{
    dbo            = @{
        Tables     = 'AWBuildVersion', 'ErrorLog'
        Views      = @()
        Procedures = @('uspPrintError')
        Functions  = 'ufnGetSalesOrderStatusText', 'ufnGetStock'
    }
    HumanResources = @{
        Tables     = 'Department', 'Employee', 'EmployeeDepartmentHistory', 'EmployeePayHistory', 'JobCandidate', 'Shift'
        Views      = @('vEmployee')
        Procedures = 'uspGetEmployeesByDepartment', 'uspUpdateEmployeeHireInfo'
        Functions  = @()
    }
    Person         = @{
        Tables     = 'Address', 'AddressType', 'BusinessEntity', 'BusinessEntityAddress', 'CountryRegion', 'EmailAddress', 'Person', 'PersonPhone', 'PhoneNumberType', 'StateProvince'
        Views      = @('vStateProvinceCountryRegion')
        Procedures = @()
        Functions  = @()
    }
    Production     = @{
        Tables     = 'Location', 'Product', 'ProductCategory', 'ProductInventory', 'ProductModel', 'ProductReview', 'ProductSubcategory', 'ScrapReason', 'UnitMeasure', 'WorkOrder'
        Views      = @()
        Procedures = @()
        Functions  = @()
    }
    Purchasing     = @{
        Tables     = 'ProductVendor', 'PurchaseOrderDetail', 'PurchaseOrderHeader', 'ShipMethod', 'Vendor'
        Views      = @('vVendorWithAddresses')
        Procedures = @()
        Functions  = @()
    }
    Sales          = @{
        Tables     = 'CreditCard', 'Currency', 'Customer', 'SalesOrderDetail', 'SalesOrderHeader', 'SalesOrderHeaderSalesReason', 'SalesPerson', 'SalesReason', 'SalesTerritory', 'SpecialOffer', 'Store'
        Views      = @('vSalesPerson')
        Procedures = @('uspGetCustomerOrders')
        Functions  = @('ufnGetCustomerOrderCount')
    }
}

$scenarios = @(
    @{ Name = 'Two schemas'; Schemas = 'Sales', 'Production' }
    @{ Name = 'Three schemas'; Schemas = 'HumanResources', 'Person', 'Purchasing' }
    @{ Name = 'Three schemas including dbo'; Schemas = 'dbo', 'HumanResources', 'Sales' }
    @{ Name = 'Case-insensitive schemas without refresh'; Schemas = 'sales', 'PERSON'; NoRefresh = $true }
)

function Invoke-Checked([string] $what, [scriptblock] $command) {
    Write-Host "==> $what" -ForegroundColor Cyan
    $output = & $command 2>&1
    if ($LASTEXITCODE -ne 0) {
        $output | Write-Host
        throw "$what failed with exit code $LASTEXITCODE"
    }
}

function Get-ExpectedObjects([string[]] $schemas) {
    $expected = foreach ($schema in $schemas) {
        $key = $database.Keys | Where-Object { $_ -ieq $schema }
        $objects = $database[$key]
        foreach ($type in 'Tables', 'Views', 'Procedures', 'Functions') {
            foreach ($name in $objects[$type]) { "$type $key.$name" }
        }
    }
    return @($expected | Sort-Object)
}

function Get-ScaffoldedObjects([string] $modelsDir) {
    $code = (Get-ChildItem $modelsDir -Filter *.cs | Get-Content -Raw) -join "`n"
    $found = @(
        # dbo is the default schema, so EF Core may leave it out of ToTable/ToView.
        # ToTable can take a third argument, such as a table comment.
        [regex]::Matches($code, 'ToTable\("(\w+)"(?:, "(\w+)")?[,)]') | ForEach-Object {
            $schema = if ($_.Groups[2].Success) { $_.Groups[2].Value } else { 'dbo' }
            "Tables $schema.$($_.Groups[1].Value)"
        }
        [regex]::Matches($code, 'ToView\("(\w+)"(?:, "(\w+)")?[,)]') | ForEach-Object {
            $schema = if ($_.Groups[2].Success) { $_.Groups[2].Value } else { 'dbo' }
            "Views $schema.$($_.Groups[1].Value)"
        }
        [regex]::Matches($code, 'EXEC @returnValue = \[(\w+)\]\.\[(\w+)\]') | ForEach-Object {
            "Procedures $($_.Groups[1].Value).$($_.Groups[2].Value)"
        }
        [regex]::Matches($code, 'DbFunction\("(\w+)", "(\w+)"\)') | ForEach-Object {
            "Functions $($_.Groups[2].Value).$($_.Groups[1].Value)"
        }
    )
    return @($found | Sort-Object -Unique)
}

if (-not $SkipBuild) {
    # The SQL project folder has a global.json that pins an SDK MSBuild.Sdk.SqlProj supports.
    Push-Location $PSScriptRoot
    try {
        Invoke-Checked 'Build AdventureWorks dacpac' { dotnet build $sqlProject }
    }
    finally {
        Pop-Location
    }

    Invoke-Checked 'Build efcpt' { dotnet build $efcptProject }
}

foreach ($file in $dacpac, $efcpt) {
    if (-not (Test-Path $file)) { throw "Missing $file, run without -SkipBuild" }
}

$workRoot = Join-Path ([System.IO.Path]::GetTempPath()) "efcpt-schema-test-$([guid]::NewGuid().ToString('N').Substring(0, 8))"
$failures = 0

try {
    foreach ($scenario in $scenarios) {
        $outputDir = Join-Path $workRoot ($scenario.Name -replace '\W+', '-')
        New-Item -ItemType Directory -Path $outputDir | Out-Null

        $config = [ordered]@{
            'code-generation' = @{ 'refresh-object-lists' = -not $scenario.NoRefresh }
            'names'           = @{ 'dbcontext-name' = 'AdventureWorksContext'; 'root-namespace' = 'SchemaTest' }
            'schemas'         = @($scenario.Schemas)
        }
        $configPath = Join-Path $outputDir 'efcpt-config.json'
        $config | ConvertTo-Json -Depth 5 | Set-Content $configPath -Encoding utf8

        Invoke-Checked "Scaffold '$($scenario.Name)' [$($scenario.Schemas -join ', ')]" {
            dotnet $efcpt $dacpac mssql -i $configPath -o $outputDir --no-readme
        }

        $expected = Get-ExpectedObjects $scenario.Schemas
        $actual = Get-ScaffoldedObjects (Join-Path $outputDir 'Models')
        $missing = @($expected | Where-Object { $_ -notin $actual })
        $unexpected = @($actual | Where-Object { $_ -notin $expected })

        if ($missing.Count -eq 0 -and $unexpected.Count -eq 0) {
            Write-Host "    PASS: $($actual.Count) objects, all from the selected schemas" -ForegroundColor Green
        }
        else {
            $failures++
            Write-Host '    FAIL' -ForegroundColor Red
            $missing | ForEach-Object { Write-Host "      missing:    $_" -ForegroundColor Red }
            $unexpected | ForEach-Object { Write-Host "      unexpected: $_" -ForegroundColor Red }
        }
    }
}
finally {
    if ($KeepOutput) {
        Write-Host "Generated code kept in $workRoot"
    }
    else {
        Remove-Item $workRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}

if ($failures -gt 0) {
    Write-Host "$failures of $($scenarios.Count) scenarios failed" -ForegroundColor Red
    exit 1
}

Write-Host "All $($scenarios.Count) scenarios passed" -ForegroundColor Green
