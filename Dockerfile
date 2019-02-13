FROM lsiobase/alpine:3.7 as builder

RUN apk add --no-cache --virtual=build-dependencies \
	autoconf \
	automake \
	boost-dev \
	cmake \
	curl \
	file \
	g++ \
	geoip-dev \
	go \
	git \
	libtool \
	make

COPY Reflection /usr/lib/go/src/github.com/h31/Reflection

RUN	cd /usr/lib/go/src/github.com/h31/Reflection/; \
	go get .; \
	go build -o main -ldflags '-extldflags "-static"' .; \
	mv main /tmp/; \
	cd /tmp; \
	rm -rf /usr/lib/go/src/github.com/h31/Reflection/; \
	apk del --purge \
	build-dependencies

FROM linuxserver/qbittorrent
COPY services.d /etc/services.d
COPY --from=builder /tmp/main /tmp/main
RUN chmod +x /tmp/main
