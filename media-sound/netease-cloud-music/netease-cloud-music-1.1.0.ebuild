# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2-utils

DESCRIPTION="Netease cloud music player"
HOMEPAGE="http://music.163.com"
NAME="netease_cloud_music"
SRC_URI="http://cdimage.deepin.com/applications/netease-cloud-music/64/${NAME}_${PV}_amd64_binary.tar.gz -> ${NAME}_${PV}_amd64_binary.tar"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-db/sqlite-3.5.9
	>=dev-libs/atk-1.12.4
	>=dev-libs/expat-2.0.1
	>=dev-libs/glib-2.37.3
	>=dev-libs/nspr-4.9
	>=dev-libs/nss-3.13.4
	>=dev-libs/openssl-1.0.0
	>=dev-qt/qtcore-5.5.0
	>=dev-qt/qtdbus-5.0.2
	>=dev-qt/qtgui-5.0.2
	>=dev-qt/qtmultimedia-5.0.2[widgets,gstreamer]
	>=dev-qt/qtnetwork-5.0.2
	>=dev-qt/qtwidgets-5.0.2
	>=dev-qt/qtx11extras-5.1.0
	>=dev-qt/qtxml-5.0.2
	>=media-libs/alsa-lib-1.0.16
	>=media-libs/fontconfig-2.11.94
	>=media-libs/freetype-2.4.2
	>=media-libs/taglib-1.9.1
	>=media-video/vlc-2.1.0
	>=net-print/cups-1.4.0
	>=sys-apps/dbus-1.9.14
	>=sys-devel/gcc-5.2
	>=sys-libs/glibc-2.14
	>=sys-libs/zlib-1.2.3.3
	>=x11-libs/cairo-1.6.0
	>=x11-libs/gdk-pixbuf-2.22.0
	>=x11-libs/gtk+-2.24.0
	>=x11-libs/libX11-1.4.99.1
	>=x11-libs/libXi-1.2.99.4
	>=x11-libs/libXrandr-1.2.99.2
	>=x11-libs/pango-1.14.0
	>x11-libs/libXcursor-1.1.2
	dev-qt/qtsql[sqlite]
	media-libs/libcue
	media-plugins/gst-plugins-meta:1.0
	media-plugins/gst-plugins-soup:1.0
	x11-libs/libXScrnSaver
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install(){
	insinto /
	doins -r ${S}/usr

	dodir /usr/bin
	exeinto /usr/bin
	fperms 775 /usr/bin/${PN}

	dodir /usr/lib/${PN}
	exeinto /usr/lib/${PN}

}
pkg_postinst(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm(){
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}