EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Converts a Python dictionary or other native data type into a valid XML string."
HOMEPAGE="https://github.com/jdunck/python-unicodecsv"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( README.md )

distutils_enable_tests pytest

src_prepare() {
    distutils-r1_src_prepare
}
