# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Speech tools for Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/projects/speech_tools/"
SRC_URI="https://github.com/VZIKL/speech_tools/archive/v2.5.tar.gz -> ${PN}-${PV}.tar.gz"


LICENSE="FESTIVAL HPND BSD rc regexp-UofT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nas X"

RDEPEND="
	nas? ( media-libs/nas )
	X? ( x11-libs/libX11
		x11-libs/libXt )
	>=media-libs/alsa-lib-1.0.20-r1
	!<app-accessibility/festival-1.96_beta
	!sys-power/powerman
	>=sys-libs/ncurses-5.6-r2
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

S=${WORKDIR}/speech_tools-2.5

src_configure() {
	local CONFIG=config/config.in
	# if use nas; then
	# 	sed -i -e "s/#.*\(INCLUDE_MODULES += NAS_AUDIO\)/\1/" \
	# 		${CONFIG} || die
	# fi
	# if ! use X; then
	# 	sed -i -e "s/-lX11 -lXt//" config/modules/esd_audio.mak || die
	# fi
	econf
}
# if compile error change MAKEOPTS to MAKEOPTS=""

src_compile() {
  emake SHARED=1
}

src_install() {
	dolib.so lib/libest*.so*

	dodoc lib/cstrutt.dtd

	insinto /usr/share/doc/${PF}
	doins -r lib/example_data

	insinto /usr/share/speech-tools
	doins -r config base_class

	insinto /usr/share/speech-tools/lib
	doins -r lib/siod

	cd include || die
	insinto /usr/include/speech-tools
	doins -r *
	dosym ../../include/speech-tools /usr/share/speech-tools/include

	cd ../bin || die
	for file in *; do
		[ "${file}" = "Makefile" ] && continue
		dobin ${file}
		dstfile="${D}/usr/bin/${file}"
		sed -i -e "s:testsuite/data:/usr/share/speech-tools/testsuite:g" \
			${dstfile} || die
		sed -i -e "s:bin:/usr/$(get_libdir)/speech-tools:g" \
			${dstfile} || die
		sed -i -e "s:main:/usr/$(get_libdir)/speech-tools:g" \
			${dstfile} || die

		# This just changes LD_LIBRARY_PATH
		sed -i -e "s:lib:/usr/$(get_libdir):g" ${dstfile} || die
	done

	cd "${S}" || die
	exeinto /usr/$(get_libdir)/speech-tools
	for file in `find main -perm /111 -type f`; do
		doexe ${file}
	done

	#Remove /usr/bin/resynth as it is broken. See bug #253556
	rm "${D}/usr/bin/resynth" || die

	# Remove bcat (only useful for testing on windows, see bug #418301).
	rm "${D}/usr/bin/bcat" || die
	rm "${D}/usr/$(get_libdir)/speech-tools/bcat" || die
}
