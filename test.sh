#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e
set -o pipefail

# Get the directory path of this script.
CMD_HOME=$( dirname "$(realpath -s "$0")" )
REPO_ROOT=${CMD_HOME}

CMAKE_BUILD_DIR=${REPO_ROOT}/cmake-build

cd "${CMAKE_BUILD_DIR}" || exit 1

echo "-- Increase soft-limit for core dump file size"
ulimit -c unlimited

ulimit -a

env | sort | grep -i -v PAT | grep -i -v TOKEN | grep -i -v API_KEY

ls -lhR .

echo "-- Run application"
echo "-- OSTYPE = ${OSTYPE}"
if [[
  # POSIX compatibility layer and Linux environment emulation for Windows
  "$OSTYPE" == "cygwin"
  ||
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
  "$OSTYPE" == "msys"
  ]]
then
  exe_file=$( ls ./src/*/cause_crash_dump.exe )
else
  exe_file=$( ls ./src/cause_crash_dump )
fi
echo "-- exe_file = ${exe_file}"
if [[ -x ${exe_file} ]]; then
  ${exe_file} \
    || echo "-- Application failed as expected"
else
  echo "-- ERROR: Cannot find exe file: ${exe_file}"
  echo 1
fi
