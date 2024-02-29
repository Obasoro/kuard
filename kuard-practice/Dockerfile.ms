FROM golang:1.17-alpine

# Install Node and NPM

RUN apk update && apk upgrade && apk add --no-cache git node.js bash npm

# get dependecies for the Gonpart of build
RUN go get -u github.com/jteeuwen/go-bindata/...
RUN go get github.com/tools/godep
RUN go get github.com/kubernetes-up-and-running/kuard


WORKDIR /go/src/github.com/kubernetes-up-and-running/kuard
# Copy all sources in
COPY . .
# This is a set of variables that the build script expects
ENV VERBOSE=0
ENV PKG=github.com/kubernetes-up-and-running/kuard
ENV ARCH=amd64
ENV VERSION=test
# Do the build. This script is part of incoming sources.
RUN /build/build.sh

# Stage 2: Deployment
FROM alpine

USER nobody:nobody
COPY --from=build /go/bin/kuard /kuard

#CMD [ "/go/bin/kuard" ]
CMD [ "/kuard" ]