# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"
inherit eutils multilib toolchain-funcs user

MY_PV="${PV}-release"
MY_P=${PN}-${MY_PV}

DESCRIPTION="Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/projects/festival/"
SITE="http://www.festvox.org/packed/festival/2.4/"
SRC_URI="${SITE}/festlex_CMU.tar.gz
	${SITE}/festlex_POSLEX.tar.gz
	${SITE}/festlex_OALD.tar.gz
	${SITE}/voices/festvox_cmu_us_aup_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_ahw_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_awb_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_axb_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_bdl_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_clb_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_fem_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_gka_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_jmk_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_ksp_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_rms_cg.tar.gz
	${SITE}/voices/festvox_cmu_us_slt_cg.tar.gz
	${SITE}/voices/festvox_rablpc16k.tar.gz
	${SITE}/voices/festvox_kallpc16k.tar.gz
	https://github.com/VZIKL/speech_tools/archive/v2.5.tar.gz -> speech-2.5.tar.gz
	https://github.com/VZIKL/festival/archive/v2.5.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="FESTIVAL HPND BSD rc regexp-UofT free-noncomm"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="~app-accessibility/speech-tools-2.5
		>=sys-libs/ncurses-5.6-r2"
RDEPEND="${DEPEND}
	media-sound/alsa-utils
"

S=${WORKDIR}/festival-2.5
pkg_setup() {
	enewuser festival -1 -1 -1 audio
}

src_prepare() {
	# tell festival to use the speech-tools we have installed.
	sed -i -e "s:\(EST=\).*:\1${EPREFIX}/usr/share/speech-tools:" "${S}"/config/config.in
	sed -i -e "s:\$(EST)/lib:/usr/$(get_libdir):" "${S}"/config/project.mak

	# fix the reference  to /usr/lib/festival
	sed -i -e "s:\(FTLIBDIR.*=.*\)\$.*:\1${EPREFIX}/usr/share/festival:" "${S}"/config/project.mak

	# Fix path for examples in festival.scm
	sed -i -e "s:\.\./examples/:${EPREFIX}/usr/share/doc/${PF}/examples/:" "${S}"/lib/festival.scm

	cp -r "${WORKDIR}"/festival/lib "${S}"
	# copy what we need for MultiSyn from speech_tools.
	cp -pr "${WORKDIR}"/speech_tools-2.5/base_class "${S}"/src/modules/MultiSyn

	echo "(Parameter.set 'Audio_Method 'Audio_Command)" >> "${S}"/lib/siteinit.scm
	echo "(Parameter.set 'Audio_Command \"aplay -q -c 1 -t raw -f s16 -r \$SR \$FILE\")" >> "${S}"/lib/siteinit.scm
}

src_configure() {
	econf || die "econf failed"
}

src_compile() {
	emake PROJECT_LIBDEPS="" REQUIRED_LIBDEPS="" LOCAL_LIBDEPS="" \
		OPTIMISE_CXXFLAGS="${CXXFLAGS}" OPTIMISE_CCFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" SHARED=2 || die "emake failed"
	sed -i -e '2c "true" ; exec /usr/bin/festival --script $0 $*' bin/text2wave
}

src_install() {
	# Install the binaries
	dobin src/main/festival
	dobin src/main/festival_client
	dobin bin/festival_server
	dobin bin/festival_server_control
	dobin bin/text2wave
	dobin bin/default_voices

	dobin lib/etc/*Linux*/audsp
	dolib.a src/lib/libFestival.a

	# Install the main libraries
	insinto /usr/share/festival
	doins -r lib/*

	# Install the examples
	insinto /usr/share/doc/${PF}
	doins -r examples

	# Need to fix saytime, etc. to look for festival in the correct spot
	for ex in "${D}"/usr/share/doc/${PF}/examples/*.sh; do
		exnoext=${ex%%.sh}
		chmod a+x "${exnoext}"
		dosed "s:${S}/bin/festival:/usr/bin/festival:" "${exnoext##$D}"
	done

	# Install the header files
	insinto /usr/include/festival
	doins src/include/*.h

	insinto /etc/festival
	doins lib/site*

	# Install the docs
	dodoc "${S}"/{ACKNOWLEDGMENTS,NEWS,README}
	doman "${S}"/doc/{festival.1,festival_client.1}

	# create the directory where our log file will go.
	diropts -m 0755 -o festival -g audio
	keepdir /var/log/festival

}

pkg_postinst() {
	elog
	elog "    Useful examples include saytime, text2wave. For example, try:"
	elog "        \"/usr/share/doc/${PF}/examples/saytime\""
	elog
	elog "    Or for something more fun:"
	elog '        "echo "Gentoo can speak" | festival --tts"'
	elog
	elog "This version also allows configuration of site specific"
	elog "initialization in /etc/festival/siteinit.scm and"
	elog "variables in /etc/festival/sitevars.scm."
	elog
}
