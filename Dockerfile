FROM lsiobase/alpine:3.7 as builder

COPY Reflection /tmp/Reflection
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
	make; \
	\
	cd /tmp/Reflection/; \
	export GOPATH=$(pwd); \
	go get main; \
	go build main; \
	mv main ..; \
	cd /tmp; \
	rm -rf /tmp/Reflection; \
	apk del --purge \
	build-dependencies

FROM linuxserver/qbittorrent
COPY services.d /etc/services.d
COPY --from=builder /tmp/main /tmp/main
