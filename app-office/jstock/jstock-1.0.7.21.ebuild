# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5

SRC_URI="https://github.com/yccheok/${PN}/releases/download/release_1-0-7-21/${PN}-${PV}-bin.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	virtual/jdk:1.7	
	app-arch/unzip
"

src_unpack() {
	unpack ${PN}-${PV}-bin.zip
	mv ${WORKDIR}/${PN} ${WORKDIR}/${PN}-${PV}
}



src_install() {
	local installdir="/opt/jstock"
	insinto ${installdir}
	doins -r .
	fperms 0755 ${installdir}/jstock.sh
}

