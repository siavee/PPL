#!/bin/bash

# This script is developed and tested on macOS Catalina 10.15.4
# using Qmake from Qt 5.15.0

declare -i errcount=0
error_collector() {
	(( errcount++ ))
}
trap error_collector ERR

# breaking requirement
if ! command -v qmake &> /dev/null
then
    echo "Please install qmake and make sure it is on PATH"
    exit 1
fi

# brew requirement
if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install gcc
fi

# vcpkg requirement
if [ ! -d "./vcpkg" ] 
then
	git clone https://github.com/Microsoft/vcpkg    
fi
if ! command -v ./vcpkg/vcpkg &> /dev/null
then
    ./vcpkg/bootstrap-vcpkg.sh
fi

# install dependencies
./vcpkg/vcpkg install glew:x64-osx
./vcpkg/vcpkg install openal-soft:x64-osx
./vcpkg/vcpkg install simpleini:x64-osx

if [ $errcount -gt 0 ]; then
	echo "$errcount errors were detected, please review that everything is setup correctly"
else
	echo "Setup successful"
fi
exit $errcount
