PKGVERSION = $(shell git describe --always)
PKGTARBALL = crlibm-$(PKGVERSION).tbz

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

distrib: build
	topkg distrib --skip-build
#	Add CRlibm files so the package is self contained.
	jbuilder exec config/prepare.exe
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

get-crlibm:
	git clone https://scm.gforge.inria.fr/anonscm/git/metalibm/crlibm.git \
	  src/crlibm

clean:
	jbuilder clean

lint:
	opam lint crlibm.opam

.PHONY: all build byte native install uninstall doc \
  distrib submit get-crlibm clean lint
