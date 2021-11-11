FROM ocaml/opam:debian-11-ocaml-4.13@sha256:0754672dc08f90477fff95b6489b92ff6020e63304fd1eabae57147ec40c4e90
SHELL [ "/usr/bin/linux32", "/bin/sh", "-c" ]
USER 1000:1000
RUN opam repository remove -a multicore || true
RUN sudo ln -f /usr/bin/opam-2.1 /usr/bin/opam
RUN opam init --reinit -ni
ENV OPAMDOWNLOADJOBS 1
ENV OPAMERRLOGLEN 0
ENV OPAMSOLVERTIMEOUT 500
ENV OPAMPRECISETRACKING 1
WORKDIR /home/opam
COPY --chown=1000:1000 . crlibm/
RUN opam pin add -k path -yn crlibm.dev crlibm/
RUN opam update --depexts
RUN opam exec -- ocamlc -config
RUN opam install --deps-only --with-test crlibm && opam install -v --with-test crlibm