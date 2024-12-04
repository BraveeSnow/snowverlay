EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python2's stdlib csv module is nice, but it doesn't support unicode. This module is a drop-in replacement which does."
HOMEPAGE="https://github.com/jdunck/python-unicodecsv"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( README.rst )

distutils_enable_tests pytest

src_prepare() {
    distutils-r1_src_prepare
}
