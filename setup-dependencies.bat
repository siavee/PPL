if not exist .\vcpkg (
	git clone https://github.com/Microsoft/vcpkg
)
if not exist .\vcpkg\vcpkg.exe (
	call .\vcpkg\bootstrap-vcpkg.bat
)

.\vcpkg\vcpkg.exe install freetype:x64-windows-static
.\vcpkg\vcpkg.exe install glew:x64-windows-static
.\vcpkg\vcpkg.exe install openal-soft:x64-windows-static
.\vcpkg\vcpkg.exe install simpleini:x64-windows-static
