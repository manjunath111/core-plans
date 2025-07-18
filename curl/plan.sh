pkg_name=curl
pkg_origin=core
pkg_version="8.14.1"
pkg_description="curl is an open source command line tool and library for
  transferring data with URL syntax."
pkg_upstream_url=https://curl.haxx.se/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('curl')
pkg_source="https://curl.haxx.se/download/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="6766ada7101d292b42b8b15681120acd68effa4a9660935853cf6d61f0d984d4"
pkg_deps=(
  core/cacerts
  core/glibc
  core/openssl
  core/zlib
  core/nghttp2
  core/libpsl
)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
  core/perl
  core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  # Patch the zsh-generating program to use our perl at build time
  sed -i "s,/usr/bin/env/perl,$(pkg_path_for perl)/bin/perl,g" scripts/completion.pl
  sed -i "s,/usr/bin/env perl,$(pkg_path_for perl)/bin/perl,g" scripts/cd2nroff
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --with-ca-bundle="$(pkg_path_for cacerts)/ssl/certs/cacert.pem" \
    --with-ssl="$(pkg_path_for openssl)" \
    --with-zlib="$(pkg_path_for zlib)" \
    --with-nghttp2="$(pkg_path_for nghttp2)" \
    --disable-manual \
    --disable-ldap \
    --disable-ldaps \
    --disable-rtsp \
    --enable-proxy \
    --enable-optimize \
    --disable-dependency-tracking \
    --enable-ipv6 \
    --without-libidn \
    --without-gnutls \
    --without-librtmp
  make
}
