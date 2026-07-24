CASKS := $(wildcard Casks/*.rb)

.PHONY: check check-casks check-docs format format-casks

format: format-casks

format-casks:
	@test -n "$(CASKS)"
	brew style --fix $(CASKS)

check: check-casks check-docs

check-casks:
	@test -n "$(CASKS)"
	@for cask in $(CASKS); do ruby -c "$$cask" || exit 1; done
	brew style $(CASKS)

check-docs:
	markdownlint README.md
