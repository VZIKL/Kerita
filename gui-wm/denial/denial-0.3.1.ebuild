EAPI=8

inherit optfeature systemd unpacker xdg

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
	x11-libs/gtk+:3
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
	usr/bin/denial-portal
	usr/bin/deniald
	usr/bin/denialctl
	usr/lib/denial/flutter/lib/libapp.so
	usr/lib/denial/settings/denial-settings
	usr/lib/denial/settings/lib/libapp.so
	usr/lib/denial/settings/lib/libflutter_linux_gtk.so
"
# Denial is the value exported by the session's DesktopNames entry.
QA_DESKTOP_FILE="usr/share/applications/dev.denial.Settings.desktop"

src_install() {
	dobin usr/bin/denial-portal
	dobin usr/bin/deniald
	dobin usr/bin/denialctl
	dobin usr/bin/denial-session
	dosym /usr/lib/denial/settings/denial-settings /usr/bin/denial-settings

	exeinto /usr/lib/denial/flutter/lib
	doexe usr/lib/denial/flutter/lib/libapp.so
	insinto /usr/lib/denial/flutter/data
	doins -r usr/lib/denial/flutter/data/flutter_assets
	exeinto /usr/lib/denial/settings
	doexe usr/lib/denial/settings/denial-settings
	exeinto /usr/lib/denial/settings/lib
	doexe usr/lib/denial/settings/lib/libapp.so
	doexe usr/lib/denial/settings/lib/libflutter_linux_gtk.so
	insinto /usr/lib/denial/settings/data
	doins usr/lib/denial/settings/data/icudtl.dat
	doins -r usr/lib/denial/settings/data/flutter_assets

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
	systemd_douserunit usr/lib/systemd/user/denial-portal.service

	insinto /usr/share/applications
	doins usr/share/applications/dev.denial.Settings.desktop
	insinto /usr/share/dbus-1/services
	doins usr/share/dbus-1/services/org.freedesktop.impl.portal.desktop.denial.service
	insinto /usr/share/xdg-desktop-portal/portals
	doins usr/share/xdg-desktop-portal/portals/denial.portal

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
	xdg_pkg_postinst
	optfeature "DDC monitor controls" app-misc/ddcutil
	optfeature "Network controls" net-misc/networkmanager
	optfeature "Wi-Fi controls without NetworkManager" net-wireless/iwd
	optfeature "PipeWire audio controls" media-video/pipewire
	optfeature "Power profile controls" sys-power/power-profiles-daemon
	optfeature "Battery status" sys-power/upower
	einfo "Select Denial from the display manager after logging out."
	einfo "OpenRC users need sys-auth/seatd built with USE=server and the seatd service enabled."
}
