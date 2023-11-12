EAPI=8

inherit go-module

DESCRIPTION="Directory/File, DNS and VHost busting tool written in Go"
HOMEPAGE="https://github.com/OJ/gobuster"
SRC_URI="https://github.com/OJ/gobuster/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://cdn.snows.world/snowverlay/net-analyzer/${P}-vendor.tar.xz"

IUSE=""
KEYWORDS="amd64 x86 arm64"
BDEPEND=">=dev-lang/go-1.19"

LICENSE="Apache-2.0 MIT BSD"
SLOT="0"

src_compile() {
	ego build
}

src_install() {
	dobin gobuster
}
