#!/usr/bin/env bash
set -euo pipefail
cd "${BASH_SOURCE[0]%/*}/.."
"$BASH" scripts/doctor.sh
repo_root=$(git rev-parse --show-toplevel) || { echo 'Ce dossier doit être un clone Git autonome.' >&2; exit 1; }
[[ $(cd "$repo_root" && pwd -P) == "$(pwd -P)" ]] || { echo 'Refus de modifier le dépôt parent : Git absent de ce clone.' >&2; exit 1; }
for hook in commit-msg; do
  [[ -f ".githooks/$hook" ]] || { printf 'Hook absent : .githooks/%s\n' "$hook" >&2; exit 1; }
done
git config --local core.hooksPath .githooks
printf 'Hooks du clone activés.\n'
