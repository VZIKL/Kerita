# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit unpacker

DESCRIPTION="Wechat client build with electron"
HOMEPAGE="https://github.com/geeeeeeeeek/electronic-wechat"
SRC_URI="amd64? ( https://github.com/geeeeeeeeek/electronic-wechat/releases/download/V2.0/linux-x64.tar.gz -> ${P}-amd64.tar.gz )
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	x11-libs/gtk+:2
	gnome-base/libgnome-keyring
	gnome-base/gnome-keyring
	${PYTHON_DEPS}
	dev-util/desktop-file-utils
	gnome-base/gconf
	net-libs/nodejs[npm]
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	media-libs/alsa-lib
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/electronic-wechat-linux-x64"
src_install(){
	insinto /opt/${PN}
	doins -r *
	fperms 775 /opt/${PN}/electronic-wechat
	dosym /opt/${PN}/electronic-wechat /usr/bin/wechat
}
