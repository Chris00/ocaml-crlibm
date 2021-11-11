PKGVERSION = $(shell git describe --always)
PKGTARBALL = crlibm-$(PKGVERSION).tbz

all build:
	dune build @install @runtest

speed:
	dune exec tests/speed.exe

test:
	docker build -f Dockerfile .

install uninstall:
	dune $@

doc:
	dune build @doc
	sed -e 's/%%VERSION%%/$(PKGVERSION)/' --in-place \
	  _build/default/_doc/_html/crlibm/Crlibm/index.html

get-crlibm:
	git subtree add -P src/crlibm \
	  https://scm.gforge.inria.fr/anonscm/git/metalibm/crlibm.git \
	  master

clean:
	dune clean

lint:
	opam lint crlibm.opam

.PHONY: all build speed test install uninstall doc get-crlibm clean lint
