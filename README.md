[![Build Status](https://travis-ci.org/Chris00/ocaml-crlibm.svg?branch=master)](https://travis-ci.org/Chris00/ocaml-crlibm)

Crlibm
======

This module is a binding to [CRlibm][], an efficient and proved
correctly-rounded mathematical library.  CRlibm is now superseded by
[MetaLibm][] but the latter requires some polishing and documentation.
For the user convenience, this module embeds the relevant C code from
the [CRlibm Git repository][crlibm-git].


[CRlibm]: https://web.archive.org/web/20161027224938/http://lipforge.ens-lyon.fr/www/crlibm
[crlibm-git]: https://scm.gforge.inria.fr/anonscm/git/metalibm/crlibm.git
[MetaLibm]: http://www.metalibm.org/


Install
-------

The easier is to use opam:

    opam install crlibm
