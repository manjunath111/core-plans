$pkg_name="powershell"
$pkg_origin="core"
$pkg_version="7.2.2"
$pkg_license=@("MIT")
$pkg_upstream_url="https://msdn.microsoft.com/powershell"
$pkg_description="PowerShell is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized for dealing with structured data (e.g. JSON, CSV, XML, etc.), REST APIs, and object models. It includes a command-line shell, an associated scripting language and a framework for processing cmdlets."
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/PowerShell/PowerShell/releases/download/v$pkg_version/PowerShell-$pkg_version-win-x64.zip"
$pkg_shasum="e639b5f47d6d39b5942df70ada4a69a1c85616747622582eedfb197b8ccad298"
$pkg_filename="powershell-$pkg_version-win-x64.zip"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}

function Invoke-Check() {
    $versionTable = ./pwsh.exe -command '$PSVersionTable'
    $passed = $false

    $versionTable | ForEach-Object {
        if($_.Trim().StartsWith('GitCommitId')) {
            $passed = $_.Trim().EndsWith($pkg_version)
        }
    }

    if(!$passed) {
        Write-Error "Check failed to confirm powershell version as $pkg_version"
    }
}
