FROM alpine:3.20
SHELL ["/bin/busybox", "ash", "-o", "pipefail", "-c"]

LABEL org.opencontainers.image.description="Docker image based on Alpine with oxipng installed"
LABEL org.opencontainers.image.source="https://github.com/maxx-timing/docker-oxipng"

ENV OXIPNG_VERSION=9.1.2
RUN apk add --no-cache libgcc \
 && apk add --no-cache --virtual .build cargo \
 && wget -qO- "https://crates.io/api/v1/crates/oxipng/$OXIPNG_VERSION/download" \
    | tar xfz - \
 && cd "oxipng-$OXIPNG_VERSION" \
 && cargo build --release --locked \
 && strip target/release/oxipng \
 && mv target/release/oxipng /usr/bin/oxipng \
 && cd .. \
 && rm -r "oxipng-$OXIPNG_VERSION" /root/.cargo \
 && apk del --no-cache .build
