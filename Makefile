BASH=/bin/bash

concat:
	@echo '#!/bin/bash' >imosh
	@echo '# imosh is a utility library for BASH.' >>imosh
	@echo '#' >>imosh
	@echo '# For more details, see https://github.com/imos/imosh' >>imosh
	@echo '' >>imosh
	@echo "IMOSH_VERSION='$$(git log --pretty=format:'%ci (%h)' library | head -n 1)'" >>imosh
	@echo '' >>imosh
	@for directory in library/*; do \
	  for file in "$${directory}"/*.sh "$${directory}"/*/*.sh; do \
	    if [ -f "$${file}" ]; then \
	      cat "$${file}"; \
	      echo; \
	    fi; \
	  done; \
	done >> imosh
	@chmod +x imosh
	@chmod +x tool/update-readme.sh
	@./tool/update-readme.sh
	@IMOSH_USE_DEFINE_FLAGS=1 \
	    ./tool/print-flag-variables.sh > library/90-flags/50-variables.sh
.PHONY: concat

all: info bug test

info:
	$(BASH) --version
	env
	$(BASH) -c shopt
.PHONY: info

bug:
	-@$(BASH) test/main.sh test/bash_bug.sh
.PHONY: bug

test: concat
	@if ! $(BASH) test/main.sh test/*_test.sh test/*/*_test.sh; then exit 1; fi
.PHONY: test

benchmark: concat
	@time $(BASH) -c "for i in {1..10}; do $(BASH) -c '. ./imosh'; done"
.PHONY: benchmark
