# Episode Tracker
Episode tracker to keep track of episodes watched in video works (anime, movies, dramas).

## Requirements
- Docker 27.3.1
- Docker Compose v2.29.7

## Dependencies
- Flutter
- Firebase

## Run on development mode
1. Set up docker container.
```bash
$ docker compose up
```

2. Enter docker container, and start the Flutter app.
- attaching the container to the terminal.
```bash
$ docker compose exec app bash && make start
```

- connecting to the container using `Dev Container` (VSCode extension).
  - connect to the container by "reopen in container"
  - exit to the local directory by "reopen file locally"
```bash
$ (devcontainer) make start
```

## Install onto local physical device (iOS)
1. Install flutter, cocoapods, and xcode onto Mac (using Homebrew).
```bash
$ brew install --cask flutter
$ brew install cocoapods

# install xcode via mas, specifing app id
$ brew install mas
$ mas install 497799835 # xcode
```

2. Open `Runner.xcworkspace` on xcode, and set development team and bundle identifier.
```bash
$ open app/ios/Runner.xcworkspace
```
- xcode needs support for some iOS needs to be downloaded, in order to run the scheme
- development team and bundle identifier can be updated at *Targets ("Runner") > Signing & Capabilities*

3. Run the flutter app with the attached physical device.
```bash
# from iOS14+, the app cannot be opened from home in debug mode
# `flutter devices` shows device ids
$ flutter run --release -d DEVICE_ID
```
- for iOS 16 or later, the physical device requires to enable `Developer Mode`, which can be set under *Settings > Privacy & Security > Developer Mode*
