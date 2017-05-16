# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit unpacker

DESCRIPTION="An object-oriented visual programming environment based"
HOMEPAGE="http://repmus.ircam.fr/openmusic/home"
SRC_URI="amd64? ( https://forge.ircam.fr/p/OM/downloads/get/OM_6.12-4.deb )"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
S=${WORKDIR}

DEPEND="
media-libs/portmidi
"
RDEPEND="${DEPEND}"

src_install(){
	insinto /
	doins -r ${S}/usr

	dodir /usr/share
	exeinto /usr/share

	dodir /usr/bin
	exeinto /usr/bin
	fperms 775 /usr/bin/openmusic
	fperms 775 /usr/bin/OM_6.12
}
