#!/usr/bin/env bash
set -euo pipefail
root=$(cd "${BASH_SOURCE[0]%/*}/../.." && pwd -P)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
clone="$tmp/clone with spaces"
mkdir -p "$clone/scripts"
cp "$root/scripts/doctor.sh" "$root/scripts/setup.sh" "$clone/scripts/"
cp -R "$root/.githooks" "$clone/"
git -C "$clone" init -q
git -C "$clone" add .
git -C "$clone" -c user.name=Test -c user.email=test@example.invalid commit -qm 'chore: fixture'
for _ in 1 2; do "$BASH" "$clone/scripts/setup.sh"; done
[[ $(git -C "$clone" config --local --get core.hooksPath) == .githooks ]] || exit 1
for hook in commit-msg; do cmp "$root/.githooks/$hook" "$clone/.githooks/$hook"; done
git -C "$clone" worktree add -q -b test-linked "$tmp/linked worktree"
"$BASH" "$tmp/linked worktree/scripts/setup.sh"
[[ $(git -C "$tmp/linked worktree" config --local --get core.hooksPath) == .githooks ]] || exit 1
rm "$clone/.githooks/commit-msg"
if "$BASH" "$clone/scripts/setup.sh"; then echo 'Hook absent accepté' >&2; exit 1; fi
# A folder inside another repo must never configure that parent's hooks.
mkdir -p "$clone/child/scripts"
cp "$root/scripts/"*.sh "$clone/child/scripts/"
cp -R "$root/.githooks" "$clone/child/"
git -C "$clone" config --local core.hooksPath unchanged-parent
if "$BASH" "$clone/child/scripts/setup.sh"; then echo 'Dépôt parent accepté' >&2; exit 1; fi
[[ $(git -C "$clone" config --local --get core.hooksPath) == unchanged-parent ]] || exit 1
printf 'setup contracts: passed\n'
