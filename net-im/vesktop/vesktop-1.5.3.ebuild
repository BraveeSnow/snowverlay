EAPI=8

CHROMIUM_LANGS="
	af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk ur vi zh-CN zh-TW
"

inherit chromium-2 desktop xdg

HOMEPAGE="https://github.com/Vencord/Vesktop"
DESCRIPTION="Vesktop is a custom Discord App aiming to give you better performance and improve linux support"
SRC_URI="https://github.com/Vencord/${PN}/releases/download/v${PV}/${P}.tar.gz"
LICENSE="GPL-3"

KEYWORDS="~amd64"
SLOT="0"

DESTDIR="/opt/${PN}"

src_configure() {
	chromium_suid_sandbox_check_kernel_config
}

src_prepare() {
	default

	pushd "locales/" >/dev/null || die "location change for language cleanup failed"
	chromium_remove_language_paks
	popd >/dev/null || die "location reset for language cleanup failed"
}

src_install() {
	exeinto "${DESTDIR}"
	doexe "${PN}" chrome-sandbox chrome_crashpad_handler libEGL.so libffmpeg.so libGLESv2.so libvk_swiftshader.so libvulkan.so.1
	dosym "${DESTDIR}/${PN}" "/usr/bin/${PN}"

	# set the setuid bit for chrome-sandbox
	fowners root "${DESTDIR}/chrome-sandbox"
	fperms 4711 "${DESTDIR}/chrome-sandbox"

	insinto "${DESTDIR}"
	doins chrome_100_percent.pak chrome_200_percent.pak icudtl.dat resources.pak snapshot_blob.bin v8_context_snapshot.bin
	insopts -m0755
	doins -r locales resources

	# desktop stuff
	domenu "${FILESDIR}/${PN}.desktop"
	doicon -s 256 "${FILESDIR}/vesktop.png"
}

pkg_postinst() {
	xdg_pkg_postinst
}
