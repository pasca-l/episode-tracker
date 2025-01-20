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

## Install onto local device
To be determined...
