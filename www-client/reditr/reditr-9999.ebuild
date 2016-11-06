# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="The Client for Reddit"
HOMEPAGE="http://reditr.com/"
SRC_URI="amd64? (http://reditr.com/downloads/linux/reditr_amd64.deb)
		x86? (http://reditr.com/downloads/linux/reditr_i386.deb)
"

LICENSE="Reditr"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=""
S=${WORKDIR}

src_compile(){
	tar xf ${WORKDIR}/data.tar.gz
	rm control.tar.gz debian-binary data.tar.gz
}

src_install(){
	insinto /opt/reditr
}
