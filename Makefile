a.out: test.d luah.d
	gdc test.d -llua5.1 -o $@
