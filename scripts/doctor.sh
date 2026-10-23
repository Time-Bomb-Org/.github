#!/usr/bin/env bash
set -euo pipefail
fail() { printf '%s\n' "$*" >&2; exit 1; }
for tool in uname bash git; do
  command -v "$tool" >/dev/null || fail "$tool absent : installer Git et Bash ; sous Windows, ouvrir Git Bash."
done
platform=$(uname -s)
case "$platform" in
  MINGW*|MSYS*|CYGWIN*)
    command -v tr >/dev/null || fail 'tr absent : ouvrir Git Bash.'
    case "$(command -v bash | tr '[:upper:]' '[:lower:]')" in
      *windows/system32/*) fail 'Le lanceur WSL ne remplace pas Git Bash. Ouvrir Git Bash ou corriger PATH.';;
    esac;;
  Linux)
    case "$(uname -r)" in
      *[Mm]icrosoft*|*WSL*)
        case "$(command -v git)" in *.exe|*.EXE|/mnt/[a-zA-Z]/*) fail 'WSL : installer Git Linux dans la distribution.';; esac;;
    esac;;
  Darwin) :;;
  *) fail "Système non pris en charge : $platform";;
esac
printf 'Git et Bash disponibles (%s).\n' "$platform"
