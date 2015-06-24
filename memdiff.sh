#!/bin/bash

EXE="./msp430-emu"
BEGIN="${1}"
END="${2}"
TRACE="trace-${BEGIN}-${END}"
ROM="73-430F2132A-qfn-20140930.bin"
MEMDUMP="memdump-${BEGIN}-${END}"
MEMDIFF="memdiff-${BEGIN}-${END}"

${EXE} -t ${TRACE} -x -b ${BEGIN} -e ${END} ${ROM} -m memdump

diff -y --suppress-common-lines <(xxd ${ROM} | cut -d' ' -f1-9 ) <(xxd memdump | cut -d' ' -f1-9 ) | sed 's/[ \t]\+|\t[ \t0-9a-f]\+:/ |/g' > ${MEMDIFF}
rm memdump

