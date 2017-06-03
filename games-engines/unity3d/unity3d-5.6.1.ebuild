# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

BUILDTAG=20170511
PV_F=${PV}xf1
DESCRIPTION="Unity3 Game Engine"
HOMEPAGE="https://unity3d.com"
SRC_URI="http://beta.unity3d.com/download/6a86e542cf5c/unity-editor-installer-${PV_F}Linux.sh -> ${P}+${BUILDTAG}.sh"

LICENSE="uinty3d"
SLOT="0"
KEYWORDS="-* ~amd64 amd64"
RESTRICT="mirror"


RDEPEND="sys-devel/gcc[multilib]
	media-libs/alsa-lib
	x11-libs/cairo
	sys-libs/libcap
	net-print/cups
	sys-apps/dbus
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	gnome-base/gconf
	x11-libs/gdk-pixbuf
	media-libs/mesa
	dev-libs/glib:2
	virtual/glu
	x11-libs/gtk+:2
	dev-dotnet/gtk-sharp
	dev-dotnet/gnome-sharp
	dev-lang/mono
	dev-libs/nspr
	dev-libs/nss
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	sys-libs/zlib
	media-libs/libpng
	dev-db/postgresql
	sys-apps/lsb-release
	x11-misc/xdg-utils
	net-libs/nodejs[npm]
	sys-apps/fakeroot"

S="${WORKDIR}/unity-editor-${PV_F}Linux"
FILE="/opt/${P}"


src_unpack() {
	yes | fakeroot sh "${DISTDIR}/${P}+${BUILDTAG}.sh" > /dev/null || die "Failed unpacking archive!"
}

src_install() {

	insinto ${FILE}
	doins -r ${S}/*

	insopts "-Dm775"

	fperms 755 "${FILE}/Editor/Unity"
	fperms 755 "${FILE}/Editor/UnityHelper"
	fperms 755 "${FILE}/MonoDevelop/bin/monodevelop"

	dosym ${FILE}/Editor/Unity /usr/bin/Unity
}


pkg_postinst() {
	chmod 4755 "${FILE}/Editor/chrome-sandbox" || die
}
