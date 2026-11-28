#!/usr/bin/env bash
# Checks the HOTP core of `pass otp` against RFC 6238 (SHA1) vectors.
# Only the 6-digit truncation is ours; the 8-digit reference values end in the
# same 6 digits because 10^8 is a multiple of 10^6.
#
# Run: bash tests/otp.test.bash

set -euo pipefail

for dep in openssl xxd; do
  command -v "$dep" >/dev/null 2>&1 || {
    echo "missing dependency: $dep"
    exit 1
  }
done

here="$(cd "${0%/*}" && pwd)"
OTP_LIB_ONLY=1 # otp.bash is sourced by pass; here we only want its hotp()
# shellcheck source=../.extensions/otp.bash
source "$here/../.extensions/otp.bash"
unset OTP_LIB_ONLY

# base32 GEZDGNBVGY3TQOJQGEZDGNBVGY3TQOJQ is "12345678901234567890"
hexkey="3132333435363738393031323334353637383930"
status=0

check() { # check <unix time> <expected 6 digits>
  local got
  got="$(hotp "$hexkey" "$(printf '%.16x' "$(($1 / 30))")")" || {
    echo "FAIL T=$1: hotp returned an error"
    status=1
    return
  }
  if [[ "$got" != "$2" ]]; then
    echo "FAIL T=$1: got $got, want $2"
    status=1
  fi
}

check 59 287082
check 1111111109 081804
check 1234567890 005924
check 2000000000 279037

if [[ $status -eq 0 ]]; then
  echo "otp: 4 RFC 6238 vectors ok"
fi
exit $status
