$pkg_name="go23"
$pkg_origin="core"
$pkg_version="1.23.6"
$pkg_description="Go is an open source programming language that makes it easy to build simple, reliable, and efficient software."
$pkg_upstream_url="https://golang.org/"
$pkg_license=@("BSD-3-Clause")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://dl.google.com/go/go$pkg_version.windows-amd64.msi"
$pkg_shasum="d2a587cbf856ed3e8583378cb43259d8e5e2aa663a21049ad0254fe19c22569f"
$pkg_build_deps=@("core/lessmsi")
$pkg_dirname="go23"
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-Unpack {
    mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
        lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
    } finally { Pop-Location }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/go$pkg_version.windows-amd64/SourceDir/Go/*" "$pkg_prefix" -Recurse -Force
}

function Invoke-Check() {
    (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/go$pkg_version.windows-amd64/SourceDir/Go/bin/go.exe" version).StartsWith("go version go$pkg_version")
}
