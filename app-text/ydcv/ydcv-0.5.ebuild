# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5} )

inherit distutils-r1
DESCRIPTION="YouDao Console online translate"
HOMEPAGE="https://github.com/felixonmars/ydcv"
SRC_URI="https://github.com/felixonmars/ydcv/archive/0.5.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-3.4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV}"

src_compile(){
	esetup.py install --root="${D}"usr
}
