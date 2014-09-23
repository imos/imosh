concat:
	@echo '#!/bin/bash' >imosh
	@echo '# imos is a utility library for BASH.' >>imosh
	@echo '' >>imosh
	@echo "IMOSH_VERSION='$$(git log --pretty=format:'%ci (%h)' library | head -n 1)'" >>imosh
	@echo '' >>imosh
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
