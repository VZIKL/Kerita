# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Nintendo Switch Emulator"
HOMEPAGE="https://yuzu-emu.org/"
EGIT_REPO_URI="https://github.com/yuzu-emu/yuzu.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~amd64"
IUSE=""

DEPEND="media-libs/libsdl2
dev-qt/qtcore
dev-qt/qtopengl
>=sys-devel/gcc-7.1.0
>=dev-util/cmake-3.6.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	cmake-utils_src_configure
}
src_compile(){
	cmake-utils_src_compile
}

src_install(){
	cmake-utils_src_install
}
