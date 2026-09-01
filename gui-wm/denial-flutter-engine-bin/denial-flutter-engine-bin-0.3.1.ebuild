EAPI=8

inherit unpacker

DESCRIPTION="Pinned Flutter Engine runtime for Denial"
HOMEPAGE="https://github.com/denialwm/denial"
SRC_URI="https://github.com/denialwm/denial/releases/download/v${PV}/denial-flutter-engine_${PV}-1_amd64.deb"
S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
REQUIRED_USE="elibc_glibc"
RESTRICT="strip"

RDEPEND="
	>=sys-libs/glibc-2.39
	media-libs/fontconfig
"

QA_PREBUILT="
	usr/lib/denial/flutter/lib/libflutter_engine.so
"

src_install() {
	# The Debian payload is unpacked by unpacker.eclass below ${S}.
	insinto /usr/lib/denial/flutter/data
	doins usr/lib/denial/flutter/data/icudtl.dat

	exeinto /usr/lib/denial/flutter/lib
	doexe usr/lib/denial/flutter/lib/libflutter_engine.so

	insinto /usr/share/denial/flutter-engine
	doins -r usr/share/denial/flutter-engine/*

	if [[ -d usr/share/doc/denial-flutter-engine ]]; then
		dodoc -r usr/share/doc/denial-flutter-engine/*
	fi

	insinto /usr/share/licenses/denial-flutter-engine
	doins usr/share/licenses/denial-flutter-engine/*
}
