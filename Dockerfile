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
#RUN git clone https://github.com/h31/Reflection.git; \

COPY Reflection /tmp/Reflection
RUN cd Reflection/; \
	export GOPATH=$(pwd); \
	go get main; \
	go build main;

RUN apk del --purge \
	build-dependencies
