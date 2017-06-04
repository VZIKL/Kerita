# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

BUILDTAG=20160927
PV_F=${PV}b5
DESCRIPTION="Unity3 Game Engine"
HOMEPAGE="https://unity3d.com"
SRC_URI="http://download.unity3d.com/download_unity/linux/unity-editor-installer-${PV_F}+${BUILDTAG}.sh -> ${P}+${BUILDTAG}.sh"

LICENSE="uinty3d"
SLOT="0"
KEYWORDS="-* ~amd64 amd64"
RESTRICT="mirror"

RDEPEND="media-video/ffmpeg
net-libs/nodejs
virtual/jdk
virtual/jre
dev-util/android-studio
app-arch/gzip
dev-util/desktop-file-utils
x11-misc/xdg-utils
sys-devel/gcc[multilib]
virtual/opengl
virtual/glu
dev-libs/nss
media-libs/libpng
x11-libs/libXtst
dev-util/monodevelop
net-libs/nodejs[npm]
sys-apps/fakeroot"
S="${WORKDIR}/unity-editor-${PV}xb5Linux"
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
