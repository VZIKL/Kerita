# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit unpacker

DESCRIPTION="The Client for Reddit"
HOMEPAGE="http://reditr.com/"
SRC_URI="amd64? ( http://reditr.com/downloads/linux/reditr_amd64.deb )
x86? ( http://reditr.com/downloads/linux/reditr_i386.deb )
"

LICENSE="Reditr"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

S=${WORKDIR}

src_install(){
	insinto /
	doins -r ${S}/opt

	dodir /opt
	exeinto /opt
	fperms 775 /opt/reditr/reditr_app
	dosym /opt/reditr/reditr_app /usr/bin/reditr

	doins -r ${S}/usr

	dodir /usr/share
	exeinto /usr/share

	dodir /usr/lib
	exeinto /usr/lib
}
