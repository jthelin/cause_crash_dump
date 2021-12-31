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

exe_file=$(realpath ./src/cause_crash_dump*)
echo "-- Run application ${exe_file}"
if [[ -x ${exe_file} ]]; then
  ${exe_file} \
    || echo "-- Application failed as expected"
else
  echo "-- ERROR: Cannot find exe file: ${exe_file}"
  echo 1
fi