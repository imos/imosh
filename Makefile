concat:
	@for library in library/*.sh; do \
	  cat "$${library}"; \
	  echo; \
	done >imosh
	@chmod +x imosh
.PHONY: concat

test: concat
	bash --version
	env
	bash -c shopt
	@if ! bash test/main.sh test/*_test.sh; then exit 1; fi
.PHONY: test
