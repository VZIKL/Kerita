# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GUN General Public License v2

EAPI=6

inherit scons-utils


DESCRIPTION="physics sandbox game"
HOMEPAGE="http://powdertoy.co.uk"
SRC_URI="amd64? ( https://github.com/ThePowderToy/The-Powder-Toy/archive/v${PV}.tar.gz -> ${PN}_${PV}.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/bzip2
		media-libs/libsdl
		dev-util/scons
		>=dev-lang/lua-5.1
		x11-libs/libX11
		sys-libs/zlib
		sci-libs/fftw:3.0
"
S="${WORKDIR}/The-Powder-Toy-${PV}"
src_compile(){
	escons
}
src_install(){
	insinto /opt/${PN}
	doins -r build/*

	fperms 775 /opt/${PN}/powder64
	dosym /opt/${PN}/powder64 /usr/bin/powder
}
