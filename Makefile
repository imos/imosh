concat:
	@echo '#!/bin/bash' >imosh
	@echo "# Last update: $$(git log --date=iso --pretty=format:'%cd (%h)' library | head -n 1)" >>imosh
	@echo '#' >>imosh
	@for library in library/*.sh library/*/*.sh; do \
	  cat "$${library}"; \
	  echo; \
	done >>imosh
	@chmod +x imosh
.PHONY: concat

test: concat
	bash --version
	env
	bash -c shopt
	@if ! bash test/main.sh test/*_test.sh test/*/*_test.sh; then exit 1; fi
.PHONY: test
