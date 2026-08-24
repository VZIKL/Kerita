EAPI=8

inherit optfeature systemd unpacker

DESCRIPTION="Flutter-native Wayland compositor and desktop shell"
HOMEPAGE="https://github.com/denialwm/denial"
SRC_URI="https://github.com/denialwm/denial/releases/download/v${PV}/denial_${PV}-1_amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3+ CC-BY-SA-4.0 GPL-3 OFL-1.1"
SLOT="0"
KEYWORDS="amd64"
REQUIRED_USE="elibc_glibc"
RESTRICT="strip"

RDEPEND="
	~gui-wm/denial-flutter-engine-bin-${PV}
	>=sys-libs/glibc-2.39
	virtual/libudev
	app-shells/bash
	gnome-extra/zenity
	media-libs/fontconfig
	media-libs/libglvnd
	media-libs/libpulse
	media-libs/mesa[opengl]
	dev-libs/libinput
	sys-apps/coreutils
	sys-apps/dbus
	sys-apps/xdg-desktop-portal
	sys-apps/xdg-desktop-portal-gtk
	sys-auth/rtkit
	sys-auth/seatd
	sys-libs/pam
	gui-libs/xdg-desktop-portal-wlr
	x11-apps/xkbcomp
	x11-base/xwayland
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-misc/xkeyboard-config
"

QA_PREBUILT="
	usr/bin/deniald
	usr/bin/denialctl
	usr/lib/denial/flutter/lib/libapp.so
"

src_install() {
	dobin usr/bin/deniald
	dobin usr/bin/denialctl
	dobin usr/bin/denial-session

	exeinto /usr/lib/denial/flutter/lib
	doexe usr/lib/denial/flutter/lib/libapp.so
	insinto /usr/lib/denial/flutter/data
	doins -r usr/lib/denial/flutter/data/flutter_assets

	insinto /etc/denial
	doins etc/denial/outputs.conf
	doins etc/denial/session.conf
	insinto /etc/xdg/xdg-desktop-portal-wlr
	doins etc/xdg/xdg-desktop-portal-wlr/Denial

	insinto /usr/share/wayland-sessions
	doins usr/share/wayland-sessions/denial.desktop
	insinto /usr/share/xdg-desktop-portal
	doins usr/share/xdg-desktop-portal/denial-portals.conf
	insinto /usr/share/denial
	doins usr/share/denial/version

	systemd_douserunit usr/lib/systemd/user/denial-session.target

	for manpage in usr/share/man/man1/*.1.gz; do
		[[ -e ${manpage} ]] || continue
		local uncompressed=${T}/$(basename "${manpage%.gz}")
		gunzip -c "${manpage}" > "${uncompressed}" || die
		doman "${uncompressed}"
	done
	if [[ -d usr/share/doc/denial ]]; then
		dodoc usr/share/doc/denial/*.md usr/share/doc/denial/copyright
	fi

	insinto /usr/share/licenses/denial
	doins usr/share/licenses/denial/*
}

pkg_postinst() {
	optfeature "DDC monitor controls" app-misc/ddcutil
	optfeature "Network controls" net-misc/networkmanager
	optfeature "Wi-Fi controls without NetworkManager" net-wireless/iwd
	optfeature "PipeWire audio controls" media-video/pipewire
	optfeature "Power profile controls" sys-power/power-profiles-daemon
	optfeature "Battery status" sys-power/upower
	einfo "Select Denial from the display manager after logging out."
	einfo "OpenRC users need sys-auth/seatd built with USE=server and the seatd service enabled."
}
