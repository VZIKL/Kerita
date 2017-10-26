# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils scons-utils

DESCRIPTION="A Multi-platform 2D and 3D game engine"
HOMEPAGE="https://godotengine.org/"
SRC_URI="https://github.com/godotengine/${PN}/archive/${PV}-stable.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+freetype llvm pulseaudio openssl"

DEPEND="
	dev-util/scons
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXinerama
	media-libs/mesa
	media-libs/glu
	media-libs/alsa-lib
	pulseaudio? ( media-sound/pulseaudio )
	freetype? ( media-libs/freetype )
	llvm? ( sys-devel/llvm )
	openssl? ( dev-libs/openssl )
"
RDEPEND="${DEPEND}"

src_configure(){
	MYSCONS=(
		platform=x11
		pulseaudio=${use pulseaudio}
		use_llvm=${use llvm}
		openssl=${use openssl}
		freetype=${use freetype}
	)
}

src_compile(){
	escons ${MYSCONS}
}

src_install(){
	newicon icon.svg ${PN}.svg
	dobin bin/gdot.*
}
