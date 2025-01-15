FROM ubuntu:20.04

WORKDIR /home/local/

# install flutter
RUN apt update && apt upgrade -y \
  && apt install -y curl file git unzip xz-utils zip \
  && git clone https://github.com/flutter/flutter.git /usr/bin/flutter
ENV PATH /usr/bin/flutter/bin:$PATH

# ignores dialog
ENV DEBIAN_FRONTEND noninteractive

# Linux toolchain
RUN apt install -y clang cmake ninja-build pkg-config libgtk-3-dev

# restore default setting
ENV DEBIAN_FRONTEND newt
