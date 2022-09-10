FROM alpine:3.16

LABEL org.opencontainers.image.description="Docker image based on Alpine with oxipng installed"
LABEL org.opencontainers.image.source="https://github.com/maxx-timing/docker-oxipng"

ENV OXIPNG_VERSION=6.0.1
RUN apk add --no-cache libgcc \
 && apk add --no-cache --virtual .build cargo \
 && wget -qO oxipng.tar.gz "https://github.com/shssoichiro/oxipng/archive/v$OXIPNG_VERSION.tar.gz" \
 && tar xf oxipng.tar.gz \
 && cd "oxipng-$OXIPNG_VERSION" \
 && cargo build --release --locked \
 && strip target/release/oxipng \
 && mv target/release/oxipng /usr/bin/oxipng \
 && cd .. \
 && rm -r oxipng.tar.gz "oxipng-$OXIPNG_VERSION" /root/.cargo \
 && apk del --no-cache .build
