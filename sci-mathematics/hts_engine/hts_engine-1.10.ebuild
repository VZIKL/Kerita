# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="Engine to synthesize speech waveform from HMMs trained by hts."
HOMEPAGE="http://hts-engine.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/${PN}/${PN}_API-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
		sys-libs/glibc
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}_API-${PV}"

src_configure(){
	econf --prefix=/usr || die "econf failed"
}

src_compile(){
	emake
}

src_install(){
	emake  install
	install -D -m644 COPYING "${S}"/usr/share/licenses/${PN}/COPYING

	dobin bin/hts_engine
	#lib
	dolib.a lib/libHTSEngine.a
	#include
	insinto /usr/include/hts_engine
	doins include/HTS_engine.h
}
