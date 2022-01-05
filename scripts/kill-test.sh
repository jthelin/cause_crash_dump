#!/bin/bash

coreDumpDir=${1:-"/tmp/core"}

if [ ! -d "$coreDumpDir" ]; then
  echo "##[error] core dump directory ${coreDumpDir} has not been created"
  exit 1
else
  echo "core dump directory ${coreDumpDir} exists"
fi

DISTRO_ID=$(lsb_release --id --short)
if [[ "${DISTRO_ID}" == "Ubuntu" ]]; then
  echo "-- Show apport service status"
  service apport status
fi

echo "-- Increase core dump size limit"
ulimit -c unlimited
ulimit -a

echo "-- KILL TEST (core dump file generation test)"

sleep 100 &
kill -s SIGABRT $!
sleep 1 # A small pause to let the other process die.

for d in ${coreDumpDir} "."; do
  dd=$(realpath "${d}")
  if [ -d "${dd}" ]; then
    echo "-- Checking core dump location: ${dd}"
    coreDumpFiles=$(ls "${dd}"/*core* 2>/dev/null)
    if [ -z "${coreDumpFiles}" ]; then
      echo "##[warning] No core files were generated in directory ${dd}"
    else
      for f in ${coreDumpFiles}; do
        echo "##[info] Found core dump file: ${f}"
        # Print out a summary fingerprint of the core dump
        gdb -quiet -nh -core="${f}" -batch -ex "backtrace"
      done

      # Cleanse the core file directory, now that the test is finished.
      ls -lh "${coreDumpFiles}"
      rm -fr "${coreDumpFiles}" 2>/dev/null
    fi
  fi
done
