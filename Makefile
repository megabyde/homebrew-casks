CASKS := $(wildcard Casks/*.rb)

.PHONY: check check-casks check-docs

check: check-casks check-docs

check-casks:
	@test -n "$(CASKS)"
	@for cask in $(CASKS); do ruby -c "$$cask" || exit 1; done
	brew style $(CASKS)

check-docs:
	markdownlint README.md
