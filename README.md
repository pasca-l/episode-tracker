# Episode Tracker
Episode tracker to keep track of episodes watched in video works (anime, movies, dramas).

## Requirements
- Docker 27.3.1
- Docker Compose v2.29.7

## Dependencies
- Flutter
- Firebase

## Run on development mode
1. Set up docker container, and enter container.
```bash
docker compose up && docker compose exec app bash
```

2. Start the Flutter app.
```bash
(container) make start
```

- without attaching the container to the terminal.
```bash
docker compose exec app make start
```

- connecting to the container using `Dev Container` (VSCode extension).
  - connect to the container by "reopen in container"
  - exit to the local directory by "reopen file locally"
```bash
(devcontainer) make start
```

## Serve web compiled app locally
1. Compile the application for web.
```bash
(container) flutter pub get && flutter build web
```

2. Serve the generated file from localhost, using python.
```bash
python3 -m http.server --directory ./app/build/web
```

## Install onto local physical device (iOS)
1. Install flutter, cocoapods, and xcode onto Mac (using Homebrew).
```bash
brew install --cask flutter
brew install cocoapods

# install xcode via mas, specifing app id
brew install mas
mas install 497799835 # xcode
```

2. Open `Runner.xcworkspace` on xcode, and set development team and bundle identifier.
```bash
open app/ios/Runner.xcworkspace
```
- xcode needs support for some iOS needs to be downloaded, in order to run the scheme
- development team and bundle identifier can be updated at *Targets ("Runner") > Signing & Capabilities*

3. Run the flutter app with the attached physical device.
```bash
# from iOS14+, the app cannot be opened from home in debug mode
# `flutter devices` shows device ids
flutter run --release -d DEVICE_ID
```
- for iOS 16 or later, the physical device requires to enable `Developer Mode`, which can be set under *Settings > Privacy & Security > Developer Mode*
- to open the installed app, the app developer is required to be trusted, which can be set under *Settings > General > VPN & Device Management*
