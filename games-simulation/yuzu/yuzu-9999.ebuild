# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Nintendo Switch Emulator"
HOMEPAGE="https://yuzu-emu.org/"
EGIT_REPO_URI="https://github.com/yuzu-emu/yuzu.git"
EGIT_SUBMODULES=( externals/getopt externals/cubeb  externals/discord-rpc externals/dynarmic externals/glad externals/inih  externals/sirit  externals/unicorn externals/lurlparser  externals/json externals/httplib )


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~amd64"
IUSE=""

DEPEND="media-libs/libsdl2
media-libs/libsoundtouch
app-arch/zstd
dev-util/vulkan-headers
dev-libs/boost
dev-cpp/catch
dev-ml/fmt
dev-libs/libressl
dev-qt/qtcore
dev-qt/qtopengl
dev-libs/libzip
app-arch/lz4
sys-libs/zlib
media-libs/opus
>=sys-devel/gcc-7.1.0
>=dev-util/cmake-3.6.0
net-libs/mbedtls
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
