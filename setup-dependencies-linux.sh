#!/bin/bash

# This script is developed and tested on PopOS 20.04 LTS
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
sudo apt update && sudo apt install build-essential tar curl zip unzip -y

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
./vcpkg/vcpkg install freetype:x64-linux
./vcpkg/vcpkg install glew:x64-linux
./vcpkg/vcpkg install openal-soft:x64-linux
./vcpkg/vcpkg install simpleini:x64-linux

if [ $errcount -gt 0 ]; then
	echo "$errcount errors were detected, please review that everything is setup correctly"
else
	echo "Setup successful"
fi
exit $errcount
