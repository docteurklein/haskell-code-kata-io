FROM haskell:8.6

WORKDIR /usr/src/app

RUN adduser -u 1000 builder
RUN chown builder:builder .
USER builder

ENV PATH=$PATH:/home/builder/.cabal/bin

RUN cabal update
#COPY --chown=builder . .
#RUN cabal new-build
