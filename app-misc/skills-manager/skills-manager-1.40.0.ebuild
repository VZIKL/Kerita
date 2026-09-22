# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Desktop app for managing AI agent skills across coding tools"
HOMEPAGE="https://github.com/xingkongliang/skills-manager"
SRC_URI="
	amd64? ( https://github.com/xingkongliang/skills-manager/releases/download/v${PV}/${PN}_${PV}_amd64.deb )
	arm64? ( https://github.com/xingkongliang/skills-manager/releases/download/v${PV}/${PN}_${PV}_arm64.deb )
"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip binchecks mirror"

RDEPEND="
	dev-libs/libappindicator:3
	net-libs/webkit-gtk:4.1
	x11-libs/gtk+:3
"

QA_PREBUILT="*"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	dobin usr/bin/skills-manager usr/bin/skills-manager-cli
	domenu usr/share/applications/skills-manager.desktop

	insinto /usr/share/icons/hicolor
	doins -r usr/share/icons/hicolor/*
}
