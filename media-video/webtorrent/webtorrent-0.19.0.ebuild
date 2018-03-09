# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Streaming torrent app"
HOMEPAGE="https://webtorrent.io/desktop"
SRC_URI="https://github.com/webtorrent/webtorrent-desktop/releases/download/v0.19.0/WebTorrent-v0.19.0-linux.zip"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/WebTorrent-linux-x64"

src_install(){
	insinto /opt/${PN}
	doins -r *
	fperms +x "/opt/${PN}/WebTorrent"

	dosym "/opt/${PN}/WebTorrent" "/usr/bin/${PN}"
}
