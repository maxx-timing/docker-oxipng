FROM alpine:3.23
SHELL ["/bin/busybox", "ash", "-o", "pipefail", "-c"]

LABEL org.opencontainers.image.description="Docker image based on Alpine with oxipng installed"
LABEL org.opencontainers.image.source="https://github.com/maxx-timing/docker-oxipng"

# defaults from /usr/share/abuild/default.conf
ENV CARGO_PROFILE_RELEASE_OPT_LEVEL=s
ENV CARGO_PROFILE_RELEASE_PANIC=abort
ENV CARGO_PROFILE_RELEASE_CODEGEN_UNITS=1
ENV CARGO_PROFILE_RELEASE_LTO=true

ENV OXIPNG_VERSION=10.0.0
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
