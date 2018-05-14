PKGVERSION = $(shell git describe --always)
PKGTARBALL = crlibm-$(PKGVERSION)

all build byte native:
	jbuilder exec config/prepare.exe
	jbuilder build @install @runtest --dev

install uninstall:
	jbuilder $@

doc:
	sed -e 's/%%VERSION%%/$(PKGVERSION)/' src/crlibm.mli \
	  > _build/default/src/crlibm.mli
	jbuilder build @doc
	echo '.def { background: #f9f9de; }' >> _build/default/_doc/odoc.css

publish:
	jbuilder exec config/prepare.exe
	topkg distrib
#	Add CRlibm files so the package is self contained.
	tar --append -f _build/$(PKGTARBALL) src/crlibm/

get-crlibm:
	git clone https://scm.gforge.inria.fr/anonscm/git/metalibm/crlibm.git \
	  src/crlibm

clean:
	jbuilder clean

lint:
	opam lint crlibm.opam

.PHONY: all build byte native install uninstall doc publish get-crlibm \
  clean lint
