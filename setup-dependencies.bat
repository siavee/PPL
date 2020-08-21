REM always start fresh
del /f/q/s .\vcpkg > NUL

.\vcpkg\vcpkg.exe install freetype:x64-windows-static
.\vcpkg\vcpkg.exe install glew:x64-windows-static
.\vcpkg\vcpkg.exe install openal-soft:x64-windows-static
.\vcpkg\vcpkg.exe install simpleini:x64-windows-static
