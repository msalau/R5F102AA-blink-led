#!/bin/sh

set -e
set -x

docker run --rm -v "$(pwd):/src" msalau/rl78-elf-llvm make
