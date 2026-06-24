#!/usr/bin/env bash

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

hash="$(
  printf '%s' "$count" |
    xxd -r -p |
    openssl dgst -sha1 -mac HMAC -macopt hexkey:"$hexkey" -binary |
    xxd -ps -c 128
)"

if [[ -z "$hash" || ! "$hash" =~ ^[0-9a-fA-F]{40}$ ]]; then
  die "Failed to generate TOTP code: OpenSSL HMAC calculation failed."
fi

offset="$((16#${hash:39:1}))"
extracted="${hash:$((offset * 2)):8}"
token="$(((16#$extracted & 16#7fffffff) % 1000000))"
print="$(printf '%06d' "$token")"

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
