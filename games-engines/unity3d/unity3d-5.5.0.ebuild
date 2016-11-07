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
dev-libs/libpqxx
dev-util/monodevelop
net-libs/nodejs[npm]
sys-apps/fakeroot"
S="${WORKDIR}/unity-enditor-${PV_F}"
FILES="${S}/Files"


src_unpack() {
	yes | fakeroot sh "${DISTDIR}/${P}+${BUILDTAG}.sh" > /dev/null || die "Failed unpacking archive!"
}

src_prepare() {
	ln -s /usr/bin/python2 ${S}/Editor/python # Fix WebGL building
	mkdir -p ${FILES}
	cp -R ${FILESDIR}/* ${FILES}/
	sed -i "/^Version=/c\Version=${PV}" "${FILES}/unity-editor.desktop"
	sed -i "/^Version=/c\Version=${PV}" "${FILES}/unity-monodevelop.desktop"
	eapply_user # In case someone wants to patch .desktop files, for example
}
src_install() {
	# Install Unity3D itself
	insinto /opt/Unity
	doins -r ${S}/*

	# Install .desktop launchers
	insopts "-Dm644"
	insinto /usr/share/applications
	doins "${FILES}/unity-editor.desktop"
	doins "${FILES}/unity-monodevelop.desktop"

	# Install icons
	insinto /usr/share/icons/hicolor/256x256/apps
	doins "${S}/unity-editor-icon.png"
	insinto /usr/share/icons/hicolor/48x48/apps
	doins "${FILES}/unity-monodevelop.png"

	# Install launch binaries
	insopts "-Dm755"
	insinto /usr/bin
	doins "${FILES}/unity-editor"
	doins "${FILES}/monodevelop-unity"

	# Install EULA license
	insopts "-Dm644"
	insinto /usr/share/licenses/${PN}
	doins "${FILES}/EULA"

	fperms +x opt/Unity/Editor/Unity ${D}/opt/Unity/Editor/UnityHelper
	fperms 4755 opt/Unity/Editor/chrome-sandbox
}


pkg_postinst() {
	einfo "If has some error please"
	einfo "issue to VZIKL'github"
}
