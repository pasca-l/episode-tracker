FROM node:22.14.0-bookworm-slim

WORKDIR /home/local/

# install flutter
RUN apt update && apt upgrade -y \
  && apt install -y curl file git unzip xz-utils zip \
  && git clone https://github.com/flutter/flutter.git /usr/bin/flutter
ENV PATH=/usr/bin/flutter/bin:$PATH

# ignores dialog
ENV DEBIAN_FRONTEND=noninteractive
# install Linux toolchain
RUN apt install -y clang cmake ninja-build pkg-config libgtk-3-dev
# restore default dialog setting
ENV DEBIAN_FRONTEND=newt

# install firebase cli
RUN npm install -g firebase-tools

# install flutterfire
RUN dart pub global activate flutterfire_cli
ENV PATH=$PATH:/root/.pub-cache/bin
