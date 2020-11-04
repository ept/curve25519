%.o: %.c
	gcc -c -o $@ $<

%.test: %.o tweetnacl.o
	gcc -o $@ $^
	bash -c "diff <(./$@) $(@:%.test=%.out)"

tests: scalarmult.test
