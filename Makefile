.PHONY: setup

setup:
	@git rev-parse --show-toplevel >/dev/null 2>&1 || { echo "Run make setup from inside a Git repository." >&2; exit 1; }
	@git config --local core.hooksPath .githooks
	@echo "Commit message hook enabled for this clone."
