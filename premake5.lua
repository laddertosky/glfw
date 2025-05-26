project("GLFW")
kind("StaticLib")
language("C")
staticruntime("off")
warnings("off")

targetdir("bin/" .. outputdir .. "/%{prj.name}")
objdir("bin-int/" .. outputdir .. "/%{prj.name}")

files({
	"include/GLFW/glfw3.h",
	"include/GLFW/glfw3native.h",
	"src/glfw_config.h",
	"src/context.c",
	"src/init.c",
	"src/input.c",
	"src/monitor.c",

	"src/null_init.c",
	"src/null_joystick.c",
	"src/null_monitor.c",
	"src/null_window.c",

	"src/platform.c",
	"src/vulkan.c",
	"src/window.c",
})

filter("system:linux")
pic("On")

systemversion("latest")

files({
	"src/x11_init.c",
	"src/x11_monitor.c",
	"src/x11_window.c",

	"src/wl_init.c",
	"src/wl_monitor.c",
	"src/wl_window.c",
	"src/wayland-client-protocol.h",
	"src/wayland-client-protocol-code.h",
	"src/wayland-xdg-shell-client-protocol.h",
	"src/wayland-xdg-shell-client-protocol-code.h",
	"src/wayland-xdg-decoration-client-protocol.h",
	"src/wayland-xdg-decoration-client-protocol-code.h",
	"src/wayland-viewporter-client-protocol.h",
	"src/wayland-viewporter-client-protocol-code.h",
	"src/wayland-relative-pointer-unstable-v1-client-protocol.h",
	"src/wayland-relative-pointer-unstable-v1-client-protocol-code.h",
	"src/wayland-pointer-constraints-unstable-v1-client-protocol.h",
	"src/wayland-pointer-constraints-unstable-v1-client-protocol-code.h",
	"src/wayland-idle-inhibit-unstable-v1-client-protocol.h",
	"src/wayland-idle-inhibit-unstable-v1-client-protocol-code.h",

	"src/xkb_unicode.c",
	"src/posix_module.c",
	"src/posix_time.c",
	"src/posix_thread.c",
	"src/posix_module.c",
	"src/glx_context.c",
	"src/egl_context.c",
	"src/osmesa_context.c",
	"src/linux_joystick.c",
})

defines({
	"_GLFW_X11",
	"_GLFW_WAYLAND",
})

prebuildcommands({
	"wayland-scanner client-header /usr/share/wayland/wayland.xml src/wayland-client-protocol.h",
	"wayland-scanner private-code /usr/share/wayland/wayland.xml src/wayland-client-protocol-code.h",
	"wayland-scanner client-header /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml src/wayland-xdg-shell-client-protocol.h",
	"wayland-scanner private-code /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml src/wayland-xdg-shell-client-protocol-code.h",
	"wayland-scanner client-header /usr/share/wayland-protocols/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml src/wayland-xdg-decoration-client-protocol.h",
	"wayland-scanner private-code /usr/share/wayland-protocols/unstable/xdg-decoration/xdg-decoration-unstable-v1.xml src/wayland-xdg-decoration-client-protocol-code.h",
	"wayland-scanner client-header /usr/share/wayland-protocols/stable/viewporter/viewporter.xml src/wayland-viewporter-client-protocol.h",
	"wayland-scanner private-code /usr/share/wayland-protocols/stable/viewporter/viewporter.xml src/wayland-viewporter-client-protocol-code.h",
	"wayland-scanner client-header /usr/share/wayland-protocols/unstable/relative-pointer/relative-pointer-unstable-v1.xml src/wayland-relative-pointer-unstable-v1-client-protocol.h",
	"wayland-scanner private-code /usr/share/wayland-protocols/unstable/relative-pointer/relative-pointer-unstable-v1.xml src/wayland-relative-pointer-unstable-v1-client-protocol-code.h",
	"wayland-scanner client-header /usr/share/wayland-protocols/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml src/wayland-pointer-constraints-unstable-v1-client-protocol.h",
	"wayland-scanner private-code /usr/share/wayland-protocols/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml src/wayland-pointer-constraints-unstable-v1-client-protocol-code.h",
	"wayland-scanner client-header /usr/share/wayland-protocols/unstable/idle-inhibit/idle-inhibit-unstable-v1.xml src/wayland-idle-inhibit-unstable-v1-client-protocol.h",
	"wayland-scanner private-code /usr/share/wayland-protocols/unstable/idle-inhibit/idle-inhibit-unstable-v1.xml src/wayland-idle-inhibit-unstable-v1-client-protocol-code.h",
})

filter("system:macosx")
pic("On")

files({
	"src/cocoa_init.m",
	"src/cocoa_monitor.m",
	"src/cocoa_window.m",
	"src/cocoa_joystick.m",
	"src/cocoa_time.c",
	"src/nsgl_context.m",
	"src/posix_thread.c",
	"src/posix_module.c",
	"src/osmesa_context.c",
	"src/egl_context.c",
})

defines({
	"_GLFW_COCOA",
})

filter("system:windows")
systemversion("latest")

files({
	"src/win32_init.c",
	"src/win32_joystick.c",
	"src/win32_module.c",
	"src/win32_monitor.c",
	"src/win32_time.c",
	"src/win32_thread.c",
	"src/win32_window.c",
	"src/wgl_context.c",
	"src/egl_context.c",
	"src/osmesa_context.c",
})

defines({
	"_GLFW_WIN32",
	"_CRT_SECURE_NO_WARNINGS",
})

filter("configurations:Debug")
runtime("Debug")
symbols("on")

filter({ "system:windows", "configurations:Debug-AS" })
runtime("Debug")
symbols("on")
sanitize({ "Address" })
flags({ "NoRuntimeChecks", "NoIncrementalLink" })

filter("configurations:Release")
runtime("Release")
optimize("speed")

filter("configurations:Dist")
runtime("Release")
optimize("speed")
symbols("off")
