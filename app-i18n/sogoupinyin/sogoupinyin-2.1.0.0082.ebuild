# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI=5

DESCRIPTION="Sogou Pinyin input method"
HOMEPAGE="http://pinyin.sogou.com/linux/"
SRC_URI="amd64? ( http://pinyin.sogou.com/linux/download.php?f=linux&bit=64 -> ${PN}_${PV}_amd64.deb )
 x86? ( http://pinyin.sogou.com/linux/download.php?f=linux&bit=32 -> ${PN}_${PV}_i386.deb )"


LICENSE="Fcitx-Sogou"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.9[qt4,X,dbus]
!app-i18n/fcitx-qimpanel
net-dns/libidn
app-i18n/opencc
net-libs/libssh2
media-video/rtmpdump
dev-qt/qtdeclarative:4
dev-qt/qtgui:4
x11-apps/xprop
sys-apps/lsb-release
!app-i18n/fcitx-sogoupinyin"
DEPEND="${RDEPEND}"
S=${WORKDIR}

src_compile(){
  tar xf ${WORKDIR}/data.tar.xz
  rm control.tar.gz  data.tar.xz  debian-binary
  rm -rf usr/share/keyrings
  rm -rf etc/X11
}

src_install(){
  dodir /usr/lib/fcitx
  insinto /usr/lib/fcitx
  insopts -m0755
  doins ${S}/usr/lib/*-linux-gnu/fcitx/*
  dodir /usr/share/mime-info
  insinto /usr/share/mime-info
  install -D ${S}/usr/lib/mime/packages/fcitx-ui-sogou-qimpanel fcitx-ui-sogou-qimpanel.keys
  dodir /usr/share
  insinto /usr/share
  doins -r ${S}/usr/share/*

  dodir /usr/bin
  insinto /usr/bin
  doins  ${S}/usr/bin/*
  dodir /etc/xdg/autostart
  insinto /etc/xdg/autostart
  doins ${S}/etc/xdg/autostart/*

}

pkg_postinst(){
	einfo
	einfo "restart fcitx and run sogou-qimpanel"
	einfo "start sogou-qimpanel"
}
