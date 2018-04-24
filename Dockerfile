FROM linuxserver/qbittorrent
RUN apk update && apk add --no-cache go git
RUN apk add --no-cache --virtual=build-dependencies \
	autoconf \
	automake \
	boost-dev \
	cmake \
	curl \
	file \
	g++ \
	geoip-dev \
	git \
	libtool \
	make
COPY services.d /etc/services.d
RUN chmod a+x /etc/services.d/reflection/run
WORKDIR /tmp

COPY Reflection /tmp/Reflection
RUN cd /tmp/Reflection/; \
	export GOPATH=$(pwd); \
	go get main; \
	go build main; \
	mv main ..; \
	cd /tmp; \
	rm -rf /tmp/Reflection;

RUN apk del --purge \
	build-dependencies
