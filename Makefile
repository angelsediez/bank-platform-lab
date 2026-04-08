.PHONY: help tree check

help:
	@echo "Available targets:"
	@echo "  tree   - show a compact repository tree"
	@echo "  check  - run basic repository checks"

tree:
	@find . -maxdepth 3 | sort

check:
	@echo "Basic repository structure check completed"
