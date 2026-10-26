# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )

inherit desktop python-r1 unpacker xdg

DESCRIPTION="Next-gen IDE for parallel agentic development"
HOMEPAGE="https://github.com/stablyai/orca"
SRC_URI="https://github.com/stablyai/orca/releases/download/v${PV}/${PN}_${PV}_amd64.deb"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="elibc_glibc ${PYTHON_REQUIRED_USE}"
RESTRICT="strip binchecks mirror"

RDEPEND="
	${PYTHON_DEPS}
	>=app-accessibility/at-spi2-core-2.46.0:2[introspection]
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/nspr
	dev-libs/nss
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	sys-libs/glibc
	virtual/udev
	x11-base/xorg-server[xvfb]
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libnotify
	x11-libs/libXrandr
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
	x11-misc/xclip
	x11-misc/xdotool
	x11-misc/xdg-utils
"

QA_PREBUILT="*"

src_unpack() {
	unpack_deb "${A}"
}

src_install() {
	# Preserve executable bits on the bundled Electron and helper binaries.
	mkdir -p "${ED}/opt" || die
	cp -r opt/Orca "${ED}/opt/" || die

	fowners root /opt/Orca/chrome-sandbox
	fperms 4755 /opt/Orca/chrome-sandbox

	dosym -r /opt/Orca/resources/bin/orca-ide /usr/bin/orca-ide

	sed -i \
		'/^MimeType=/ s#x-scheme-handler/orca;x-scheme-handler/orca;#x-scheme-handler/orca;#' \
		usr/share/applications/orca-ide.desktop || die
	domenu usr/share/applications/orca-ide.desktop

	local size
	for size in 16 24 32 48 64 128 256 512; do
		newicon -s "${size}" \
			"usr/share/icons/hicolor/${size}x${size}/apps/orca-ide.png" \
			orca-ide.png
	done

	dodoc usr/share/doc/orca-ide/changelog.gz
}
