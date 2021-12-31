#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e
set -o pipefail

# Get the directory path of this script.
CMD_HOME=$( dirname "$(realpath -s "$0")" )
REPO_ROOT=${CMD_HOME}

CMAKE_BUILD_DIR=${REPO_ROOT}/cmake-build

mkdir -p "${CMAKE_BUILD_DIR}"

cd "${CMAKE_BUILD_DIR}" || exit 1

echo "-- Generate cmake build scripts"
cmake ..

echo "-- Run cmake build"
cmake --build . --target package
