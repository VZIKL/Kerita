# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit unpacker

DESCRIPTION="A new cross-platform Apple Music experience based on Electron and Vue.js written from scratch with performance in mind."
HOMEPAGE="https://cider.sh/"
SRC_URI="amd64? ( https://github.com/ciderapp/cider-releases/releases/download/v1.5.0/cider_1.5.0_amd64.deb )"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
S=${WORKDIR}

DEPEND=""
RDEPEND="${DEPEND}"

src_install(){
    insinto /
    doins -r ${S}/opt

    dodir /opt
    exeinto /opt
    fperms 775 /opt/Cider/cider 
    fperms 775 /opt/Cider/chrome_crashpad_handler
    dosym /opt/Cider/cider /usr/bin/cider
    doins -r ${S}/usr

    dodir /usr/share
    exeinto /usr/share

}
