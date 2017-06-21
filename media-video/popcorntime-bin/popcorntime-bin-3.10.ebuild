# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib

DESCRIPTION="The Client for watch TV and Movies"
HOMEPAGE="https://www.popcorntime.ws"
SRC_URI="amd64? ( https://www.popcorntime.ws/download/PopcornTime-Official/Popcorn-Time-0.3.10-Linux-64.tar.xz )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/nss
		gnome-base/gconf
		media-fonts/corefonts
		media-libs/alsa-lib
		x11-libs/gtk+:2
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"
src_install(){
	insinto /opt/${PN}
	doins -r *

	fperms 775 /opt/${PN}/Popcorn-Time
	dosym /opt/${PN}/Popcorn-Time /usr/bin/popcorn-time
	dosym /$(get_libdir)/libudev.so.1 /opt/${PN}/libudev.so.0
}
