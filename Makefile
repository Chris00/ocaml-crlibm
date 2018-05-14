PKGVERSION = $(shell git describe --always)
PKGTARBALL = crlibm-$(PKGVERSION).tbz

all build byte native: prepare
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

distrib: build
	topkg distrib --skip-build
#	Add CRlibm files so the package is self contained.
	@cd _build \
	&& tar -xf $(PKGTARBALL) \
	&& cp -a ../src/crlibm/ crlibm-$(PKGVERSION)/src \
	&& $(RM) -r $(addprefix crlibm-$(PKGVERSION)/src/crlibm/, \
	  .git docs maple gappa tests) \
	&& tar -jcf $(PKGTARBALL) crlibm-$(PKGVERSION) \
	&& $(RM) -r crlibm-$(PKGVERSION)

submit: distrib
	topkg publish
	topkg opam pkg
	topkg opam submit

prepare:
	[ -d src/crlibm ] || $(MAKE) get-crlibm
	jbuilder exec config/prepare.exe

get-crlibm:
	git clone https://scm.gforge.inria.fr/anonscm/git/metalibm/crlibm.git \
	  src/crlibm

clean:
	jbuilder clean

lint:
	opam lint crlibm.opam

.PHONY: all build byte native speed install uninstall doc \
  distrib submit prepare get-crlibm clean lint
