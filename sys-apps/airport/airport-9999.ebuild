EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit desktop python-single-r1

DESCRIPTION="A GUI/TUI tool for managing portage"
HOMEPAGE="https://github.com/BraveeSnow/airport"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/BraveeSnow/airport.git"
	AIRPORT_GIT_PTR="master"
	inherit git-r3
else
	AIRPORT_GIT_PTR="${PV}"
	SRC_URI="https://github.com/BraveeSnow/airport/releases/download/${AIRPORT_GIT_PTR}/${P}.tar.xz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
		$(python_gen_cond_dep '
			sys-apps/portage[${PYTHON_USEDEP}]
			dev-python/pyside6[${PYTHON_USEDEP}]
		')
		${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_install() {
	python_newscript airport_qt.py airport_qt
	python_domodule airport

	domenu assets/airport.desktop
}

pkg_postinst() {
	ewarn "Please note that airport is in a volatile state. It is currently"
	ewarn "not suitable for managing portage."
}
