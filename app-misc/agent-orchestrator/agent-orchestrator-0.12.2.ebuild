# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Agent IDE for managing fleets of coding agents"
HOMEPAGE="https://github.com/Untrivial-ai/agent-orchestrator"
SRC_URI="https://github.com/Untrivial-ai/agent-orchestrator/releases/download/v${PV}/${PN}-linux-x64.deb"

S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip binchecks mirror"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/glib:2
	dev-libs/libnotify
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-misc/xdg-utils
"

QA_PREBUILT="*"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	# Preserve executable bits on Electron and all bundled agent runtimes.
	dodir /usr/lib
	cp -a usr/lib/agent-orchestrator "${ED}/usr/lib/" || die

	fowners root /usr/lib/agent-orchestrator/chrome-sandbox
	fperms 4755 /usr/lib/agent-orchestrator/chrome-sandbox

	dosym -r /usr/lib/agent-orchestrator/agent-orchestrator \
		/usr/bin/agent-orchestrator
	domenu usr/share/applications/agent-orchestrator.desktop
	newicon -s 1024 usr/share/pixmaps/agent-orchestrator.png \
		agent-orchestrator.png

	dodoc usr/share/doc/agent-orchestrator/copyright
}
