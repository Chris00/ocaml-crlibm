PKGVERSION = $(shell git describe --always)
PKGTARBALL = crlibm-$(PKGVERSION).tbz

all build byte native:
	jbuilder build @install @runtest --dev

speed:
	jbuilder build tests/speed.exe
#	Execute directly to see the output progress:
	_build/default/tests/speed.exe

install uninstall:
	jbuilder $@

doc:
	sed -e 's/%%VERSION%%/$(PKGVERSION)/' src/crlibm.mli \
	  > _build/default/src/crlibm.mli
	jbuilder build @doc
	@echo '.def { background: #f0f0f0; }' \
	  >> _build/default/_doc/_html/odoc.css

get-crlibm:
	git subtree add -P src/crlibm \
	  https://scm.gforge.inria.fr/anonscm/git/metalibm/crlibm.git \
	  master

clean:
	jbuilder clean

lint:
	opam lint crlibm.opam

.PHONY: all build byte native speed install uninstall doc \
  distrib submit get-crlibm clean lint
