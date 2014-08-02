concat:
	@for library in library/*.sh; do \
	  cat "$${library}"; \
	  echo; \
	done >imosh
	@chmod +x imosh
.PHONY: concat

test: concat
	bash --version
	@IMOS_TEST_IS_FAILED=0; \
	for test in test/*_test.sh; do \
	  if PATH="$$(pwd):$${PATH}" bash test/main.sh "$${test}"; then \
	    echo "$${test} ... Passed" >&2; \
	  else \
	    echo "$${test} ... Failed" >&2; \
	    IMOS_TEST_IS_FAILED=1; \
	  fi \
	done; \
	if (( IMOS_TEST_IS_FAILED )); then exit 1; fi
.PHONY: test
