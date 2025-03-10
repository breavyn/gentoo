# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="buildsystem-${PV}"
DESCRIPTION="Build system used for netsurf and its libs"
HOMEPAGE="https://www.netsurf-browser.org"
SRC_URI="https://download.netsurf-browser.org/libs/releases/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~ppc ppc64 ~riscv ~sparc x86"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${P}-parallel-pre-post-targets.patch" )

src_prepare() {
	default
	sed -e 's:/bin/which:which:' -i "makefiles/Makefile.tools" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	insinto /usr/share/netsurf-buildsystem
	newins "${FILESDIR}/gentoo-helpers-r2.sh" gentoo-helpers.sh
}
