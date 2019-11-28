# 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )
DISTUTILS_SINGLE_IMPL="1"

inherit git-r3 distutils-r1 gnome2-utils

DESCRIPTION="Wallpaper changer for Linux"
HOMEPAGE="http://peterlevi.com/variety/"
EGIT_REPO_URI="https://github.com/varietywalls/${PN}.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/python-distutils-extra[${PYTHON_USEDEP}]"
RDEPEND="
${DEPEND}
${PYTHON_DEPS}
x11-libs/gtk+:3[introspection]
>=x11-libs/libnotify-0.7[introspection]
dev-python/configobj[${PYTHON_USEDEP}]
dev-python/pycurl[${PYTHON_USEDEP}]
dev-python/dbus-python[${PYTHON_USEDEP}]
x11-libs/pango[introspection]
>=dev-libs/glib-2
dev-python/pillow[${PYTHON_USEDEP}]
dev-python/pycairo[${PYTHON_USEDEP}]
dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
net-libs/webkit-gtk:4[introspection]
gnome-extra/yelp
media-gfx/imagemagick
media-libs/gexiv2[python,introspection]
dev-libs/libappindicator:3[introspection]
dev-python/lxml[${PYTHON_USEDEP}]
>=dev-lang/python-3.5"


pkg_postinst(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
