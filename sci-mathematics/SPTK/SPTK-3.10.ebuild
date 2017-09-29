# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils

DESCRIPTION="A suite of speech signal processing tools."
HOMEPAGE="http://sp-tk.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/sp-tk/${PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/glibc
		app-shells/tcsh
		x11-libs/libX11
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV}"

src_configure(){
	econf --prefix=/opt/${PN} || die "econf failed"
}


src_install(){
	emake DESTDIR="${D}" install
	install -D -m644 COPYING "${S}"/usr/share/licenses/${PN}/COPYING

	dolib.a lib/*.a

	insinto /usr/include/"${PN}"
	doins include/SPTK.h
}
