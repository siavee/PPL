git clone https://github.com/Microsoft/vcpkg
call .\vcpkg\bootstrap-vcpkg.bat

.\vcpkg\vcpkg.exe install freetype
.\vcpkg\vcpkg.exe install glew
.\vcpkg\vcpkg.exe install openal-soft
.\vcpkg\vcpkg.exe install x-plane
.\vcpkg\vcpkg.exe install simpleini
