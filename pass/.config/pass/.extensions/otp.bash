#!/usr/bin/env bash

# hotp <hexkey> <counter in hex> -> 6-digit code (RFC 6238, SHA1)
hotp() {
  local hash offset
  hash="$(
    printf '%s' "$2" |
      xxd -r -p |
      openssl dgst -sha1 -mac HMAC -macopt hexkey:"$1" -binary |
      xxd -ps -c 128
  )"
  [[ "$hash" =~ ^[0-9a-fA-F]{40}$ ]] || return 1
  offset="$((16#${hash:39:1}))"
  printf '%06d' "$(((16#${hash:$((offset * 2)):8} & 16#7fffffff) % 1000000))"
}

# pass sources extensions into its own shell, so a plain script check cannot
# tell "loaded by pass" from "loaded by a test": tests/otp.test.bash sets
# OTP_LIB_ONLY to skip the command itself.
if [[ -n "${OTP_LIB_ONLY:-}" ]]; then
  return 0
fi

cmd="${2%/}"
path="${1%/}"

case "$1" in
  -c|--clip|-qr|--qrcode)
    cmd="$1"
    path="${2%/}"
    ;;
esac

if [[ -z "$path" ]]; then
  echo "Usage: pass otp <path> [-c | --clip] [-qr | --qrcode]"
  echo "Generate a TOTP code from a pass entry."
  echo "Example: pass otp mytotp"
  exit 1
fi

check_sneaky_paths "$path"

passfile="$PREFIX/$path.gpg"

[[ -f "$passfile" ]] || die "Pass entry not found: $path"

for dep in gpg xxd openssl base32; do
  command -v "$dep" >/dev/null 2>&1 || die "Missing dependency: $dep"
done

if [[ "$cmd" == "-qr" || "$cmd" == "--qrcode" ]]; then
  command -v qrencode >/dev/null 2>&1 || die "Missing dependency: qrencode"
fi

decrypted="$(gpg -d "${GPG_OPTS[@]}" "$passfile")" || die "Failed to decrypt pass entry: $path"

base32_secret="$(
  echo "$decrypted" |
    grep -Ei '^(otp|secret)\s*:' |
    head -n 1 |
    sed -E 's/^[^:]+:[[:space:]]*//'
)"

if [[ -z "$base32_secret" ]]; then
  base32_secret="$(echo "$decrypted" | grep -v '^[[:space:]]*$' | head -n 1)"
fi

base32_secret="$(
  echo "$base32_secret" |
    sed -E 's#^otpauth://totp/[^?]+\?##; s#.*secret=([^&]+).*#\1#' |
    tr -d '[:space:]=' |
    tr '[:lower:]' '[:upper:]'
)"

[[ -n "$base32_secret" ]] || die "Failed to find OTP secret in pass entry."

hexkey="$(
  {
    printf '%s' "$base32_secret" | base32 -d 2>/dev/null ||
    printf '%s' "$base32_secret" | base32 --decode 2>/dev/null
  } | xxd -ps -c 128
)"

[[ -n "$hexkey" ]] || die "Failed to decode OTP secret. Make sure it is valid base32."

count="$(printf '%.16x' "$(($(date +%s) / 30))")"
print="$(hotp "$hexkey" "$count")" ||
  die "Failed to generate TOTP code: OpenSSL HMAC calculation failed."

qrcode() {
  issuer="$(basename "$(dirname "$path")")"
  name="$(basename "$path")"

  qrencode -o - \
    -t UTF8 \
    -s 10 \
    -v 1 \
    -m 2 \
    -l m \
    "otpauth://totp/${name}?secret=${base32_secret}&issuer=${issuer^}"
}

case "$cmd" in
  -c|--clip)
    clip "$print"
    ;;
  -qr|--qrcode)
    qrcode
    ;;
  *)
    echo "$print"
    ;;
esac
