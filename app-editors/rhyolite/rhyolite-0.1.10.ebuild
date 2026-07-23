# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="A simple markdown editor written in Tauri, inspired by Obsidian"
HOMEPAGE="https://github.com/lockedmutex/rhyolite"
SRC_URI="https://github.com/lockedmutex/rhyolite/releases/download/v${PV}/Rhyolite_${PV}_amd64.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip binchecks mirror"

RDEPEND="
	net-libs/webkit-gtk:4.1
	x11-libs/gtk+:3
"

S="${WORKDIR}"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	# Binary
	dobin usr/bin/Rhyolite

	# Themes
	insinto /usr/lib/Rhyolite/themes
	doins usr/lib/Rhyolite/themes/*.toml

	# Desktop entry
	domenu usr/share/applications/Rhyolite.desktop

	# Icons (all hicolor sizes present in the .deb)
	local size
	for size in 30x30 32x32 44x44 50x50 71x71 89x89 107x107 128x128 142x142 150x150 256x256@2 284x284 310x310 512x512; do
		newicon -s "${size}" "usr/share/icons/hicolor/${size}/apps/Rhyolite.png" Rhyolite.png
	done
}
