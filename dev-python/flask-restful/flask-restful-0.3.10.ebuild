EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYPI_NO_NORMALIZE=1
PYPI_PN="Flask-RESTful"
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Simple framework for creating REST APIs."
HOMEPAGE="https://github.com/flask-restful/flask-restful/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
    $(python_gen_cond_dep '
        >=dev-python/aniso8601-0.82[${PYTHON_USEDEP}]
        >=dev-python/flask-0.8.0[${PYTHON_USEDEP}]
        >=dev-python/six-1.3.0[${PYTHON_USEDEP}]
        dev-python/pytz[${PYTHON_USEDEP}]
    ')
"

DOCS=( README.md )

distutils_enable_tests pytest

src_prepare() {
    distutils-r1_src_prepare
}
