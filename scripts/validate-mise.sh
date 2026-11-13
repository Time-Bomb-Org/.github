#!/usr/bin/env bash
set -euo pipefail
root=$(cd "${BASH_SOURCE[0]%/*}/.." && pwd -P)
cd "$root"
mise --version
uname -a
git rev-parse HEAD
"$BASH" tests/tooling/setup.sh

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

prepare_clone() {
  mkdir -p "$1"
  cp "$root/mise.toml" "$root/.gitattributes" "$1/"
  cp -R "$root/scripts" "$root/.githooks" "$1/"
  git -C "$1" init -q
  git -C "$1" add .
  git -C "$1" -c user.name=Test -c user.email=test@example.invalid commit -qm 'chore: fixture'
}

validate_clone() (
  cd "$1"
  mise trust
  mise tasks ls
  before=$(git config --local --get core.hooksPath || true)
  mise run doctor
  [[ $(git config --local --get core.hooksPath || true) == "$before" ]]
  mise run setup
  mise run setup
  [[ $(git config --local --get core.hooksPath) == .githooks ]]
  for hook in "$root"/.githooks/*; do
    cmp "$hook" ".githooks/${hook##*/}"
  done
  [[ ! -e parent-setup-ran ]]
)

standalone="$tmp/standalone clone with spaces"
prepare_clone "$standalone"
validate_clone "$standalone"
git -C "$standalone" worktree add -q -b test-mise-linked "$tmp/linked worktree"
validate_clone "$tmp/linked worktree"

parent="$tmp/orchestrator with spaces"
mkdir -p "$parent"
git -C "$parent" init -q
git -C "$parent" config --local core.hooksPath parent-unchanged
cat > "$parent/mise.toml" <<'TOML'
[tasks.setup]
run = "touch parent-setup-ran"
TOML
(cd "$parent" && mise trust)
prepare_clone "$parent/child clone"
validate_clone "$parent/child clone"
[[ $(git -C "$parent" config --local --get core.hooksPath) == parent-unchanged ]]
[[ ! -e "$parent/parent-setup-ran" ]]
printf 'mise setup validation: passed (standalone, worktree, nested clone)\n'
