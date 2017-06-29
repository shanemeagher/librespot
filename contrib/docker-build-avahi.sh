#!/usr/bin/env bash
set -eux

cargo build --release --no-default-features --features "alsa-backend with-avahi"

export PKG_CONFIG_ALLOW_CROSS=0

export PKG_CONFIG_PATH=/usr/lib/aarch64-unknown-linux-gnu/pkgconfig
cargo build --release --target aarch64-unknown-linux-gnu --no-default-features --features "alsa-backend with-avahi"

export PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabi/pkgconfig
cargo build --release --target arm-unknown-linux-gnueabi --no-default-features --features "alsa-backend with-avahi"

export PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig
cargo build --release --target arm-unknown-linux-gnueabihf --no-default-features --features "alsa-backend with-avahi"

export PKG_CONFIG_PATH=/usr/lib/mipsel-linux-gnu/pkgconfig
cargo build --release --target mipsel-unknown-linux-gnu --no-default-features --features "alsa-backend with-avahi"

mkdir -p /build/libdns_sd
for t in arm-linux-gnueabi arm-linux-gnueabihf mipsel-linux-gnu x86_64-linux-gnu
do
  mkdir -p /build/libdns_sd/$t
  cp /usr/lib/$t/libdns_sd.so.1 /build/libdns_sd/$t
done

