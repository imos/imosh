concat:
	@cat library/*.sh > imosh
	@chmod +x imosh
.PHONY: concat

test: concat
	@for test in test/*_test.sh; do \
	  if PATH="$$(pwd):$${PATH}" bash test/main.sh "$${test}"; then \
	    echo "$${test} ... Passed" >&2; \
	  else \
	    echo "$${test} ... Failed" >&2; \
	  fi \
	done
.PHONY: test
