EAPI=8

PYTHON_COMPAT=( pypy3 python3_{10..12} )

inherit meson python-single-r1

MY_PV="${PV}-1"

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more."
HOMEPAGE="https://github.com/flightlessmango/MangoHud"
SRC_URI="https://github.com/flightlessmango/MangoHud/releases/download/v${PV}/MangoHud-v${MY_PV}-Source.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/MangoHud-v${PV}"

LICENSE="MIT"
SLOT="0"

KEYWORDS="amd64 x86"
IUSE="dbus plot test wayland X video_cards_nvidia"
REQUIRED_USE="|| ( wayland X ) ${PYTHON_REQUIRED_USE}"

CDEPEND="
        dev-cpp/nlohmann_json
        dev-libs/spdlog
        media-libs/glfw
        media-libs/libglvnd
        media-libs/vulkan-loader
        X? (
            x11-libs/libX11
            x11-libs/libxkbcommon
        )
        video_cards_nvidia? ( x11-drivers/nvidia-drivers[static-libs(+)] )
"

BDEPEND="
        ${PYTHON_DEPS}
        dev-util/glslang
        $( python_gen_cond_dep 'dev-python/mako[${PYTHON_USEDEP}]' )
"

RDEPEND="
        ${CDEPEND}
        ${PYTHON_DEPS}
        plot? (
            $( python_gen_cond_dep '
                dev-python/numpy[${PYTHON_USEDEP}]
                dev-python/matplotlib[${PYTHON_USEDEP}]
            ' )
        )
"

DEPEND="
        ${CDEPEND}
        ${PYTHON_DEPS}
        dbus? ( sys-apps/dbus )
        wayland? ( dev-libs/wayland )
"


src_configure() {
    local emesonargs=(
        -Dmangoapp=true
        -Dmangohudctl=true
        -Dmangoapp_layer=true
        -Dinclude_doc=false
        -Duse_system_spdlog=enabled
        $(meson_feature dbus with_dbus)
        $(meson_feature plot mangoplot)
        $(meson_feature test tests)
        $(meson_feature wayland with_wayland)
        $(meson_feature X with_x11)
        $(meson_feature video_cards_nvidia with_nvml)
        $(meson_feature video_cards_nvidia with_xnvctrl)
    )

    meson_src_configure
}

src_compile() {
    meson_src_compile
}

src_install() {
    meson_src_install
}
