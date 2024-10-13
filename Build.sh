#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")"
cd ./tools/build
exec bash ./build
