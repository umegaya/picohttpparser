#
# Copyright (c) 2009-2014 Kazuho Oku, Tokuhiro Matsuno, Daisuke Murase,
#                         Shigeo Mitsunari
#
# The software is licensed under either the MIT License (below) or the Perl
# license.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

CC?=gcc
PROVE?=prove
OS := $(shell uname -s)
INSTALL_PATH?=/usr/local
SO_HEADER=picohttpparser.h
ifeq ($(OS),Linux)
SO_NAME=libpicohttpparser.so
SO_CFLAGS=-shared -O3 -fPIC
SO_LDFLAGS=
endif
ifeq ($(OS),Darwin)
SO_NAME=libpicohttpparser.dylib
SO_CFLAGS=-O3 -dynamiclib
SO_LDFLAGS=
endif

all:

so: $(SO_NAME)

$(SO_NAME): picohttpparser.c
	$(CC) -Wall $(SO_CFLAGS) $(SO_LDFLAGS) -o $@ $^

test: test-bin
	$(PROVE) -v ./test-bin

test-bin: picohttpparser.c picotest/picotest.c test.c
	$(CC) -Wall $(CFLAGS) $(LDFLAGS) -o $@ $^

clean:
	rm -f test-bin

clean_so:
	rm -f $(SO_NAME)

install_so:
	install -C -m 644 $(SO_NAME) $(INSTALL_PATH)/lib
	install -C -m 644 $(SO_HEADER)  $(INSTALL_PATH)/include

.PHONY: test
