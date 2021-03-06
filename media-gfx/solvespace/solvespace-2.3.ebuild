# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils git-r3 gnome2-utils

DESCRIPTION="Parametric 2d/3d CAD"
HOMEPAGE="http://solvespace.com/"
EGIT_REPO_URI="https://github.com/solvespace/solvespace"
EGIT_SUBMODULES=( extlib/q3d extlib/libdxfrw extlib/flatbuffers )

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
dev-util/cmake
dev-libs/json-c
dev-cpp/gtkmm:3.0
dev-cpp/pangomm
dev-libs/libspnav
media-libs/glu
sys-libs/zlib
x11-libs/cairo
media-libs/freetype
media-libs/fontconfig
"
RDEPEND="${DEPEND}"

src_configure(){
	local mycmakeargs=(
	-DCMAKE_BUILD_TYPE=Release
)
cmake-utils_src_configure
}

pkg_postinst(){
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
