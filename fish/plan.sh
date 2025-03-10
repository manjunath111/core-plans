pkg_name=fish
pkg_origin=core
pkg_version="2.7.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0' 'LGPL-2.0' 'ISC' 'BSD-2-Clause-NetBSD' 'BSD-3-Clause')
pkg_source="https://github.com/fish-shell/fish-shell/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=e42bb19c7586356905a58578190be792df960fa81de35effb1ca5a5a981f0c5a
pkg_deps=(
  core/bc
  core/coreutils
  core/gawk
  core/gcc-libs
  core/glibc
  core/grep
  core/man-db
  core/ncurses
  core/net-tools
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(share/pkgconfig)
pkg_interpreters=(bin/fish)
pkg_description="fish is a smart and user-friendly command line shell for macOS, Linux, and the rest of the family."
pkg_upstream_url="https://fishshell.com/"
