# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 qmake-utils xdg-utils

DESCRIPTION="A note-taking application that knows programmers and Markdown better."
HOMEPAGE="https://tamlok.gitee.io/vnote"
EGIT_REPO_URI="https://github.com/tamlok/vnote.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
>=dev-qt/qtcore-5.9:5
>=dev-qt/qtwebengine-5.9:5
>=dev-qt/qtsvg-5.9:5
"
EGIT_COMMIT="v${PV}"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup(){
	export INSTALL_ROOT="${D}"
}

src_configure(){
	eqmake5 VNote.pro
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
pkg_postrm(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
