#!/bin/bash

# This script is developed and tested on PopOS 20.04 LTS & Ubuntu 18.04 LTS
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

# dependencies
PKG_DEPS='build-essential tar curl zip unzip pkg-config'
if ! dpkg -s $PKG_DEPS >/dev/null 2>&1; then
	if [[ $EUID -eq 0 ]]; then
		apt update && apt install $PKG_DEPS -y
	else
	 	sudo apt update && sudo apt install $PKG_DEPS -y
	fi
fi

# always refresh vcpkg so we can be sure that we're not using stale configuration
rm -rf ./vcpkg
git clone https://github.com/siavee/vcpkg
./vcpkg/bootstrap-vcpkg.sh

# install dependencies
./vcpkg/vcpkg install glew:x64-linux
./vcpkg/vcpkg install openal-soft:x64-linux
./vcpkg/vcpkg install simpleini:x64-linux

if [ $errcount -gt 0 ]; then
	echo "$errcount errors were detected, please review that everything is setup correctly"
else
	echo "Setup successful"
fi
exit $errcount
