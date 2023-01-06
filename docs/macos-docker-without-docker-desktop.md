# Docker without Docker Desktop on MacOS

Since 2022, Docker Desktop is no longer free of change for companies above 250 employees.

While this is not a big deal if you're working on Linux (you can still use the official command line Docker),
it became a problem on MacOS, because you have to install Docker Desktop to get Docker from Docker.

However, there are free of charge alternatives:

 - [podman](https://podman.io/) - Apache License 2.0
 - [colima](https://github.com/abiosoft/colima) - MIT License

## Podman in brief
Podman in brief:
```shell
## Installation, see https://podman.io/getting-started/installation for details
brew install podman

## Startup
podman machine init
podman machine start

## Usage
podman run hello-world:latest
podman ps
```
What's noteworthy:

 * :white_check_mark: it works
 * :white_check_mark: Podman may be used together with the GUI tool: [Podman Desktop](https://podman-desktop.io/)
 * :white_check_mark: trivial installation
 * :x: have its own command line tool, which is very similar to docker (in fact Podman docs suggest creating an alias `alias docker=podman`),
  but not the same. If you use bash scripts for automating, they might be broken
 * :x: Podman driver for Minikube is experimental. While it is possible to configure podman correctly for Minikube, it's not as easy as it might
  look like - default setup doesn't work, you need to experiment with parameters to have your Minikube cluster running (in short: rootful + containerd)
 * :x: Podman is not detected as a runtime environment for testcontainers and there's no official support. Google says that it should be possible
  to have it working, but requires some more additional steps (ssh'ing into Podman VM and socket tunneling)
 * :x: in some cases Podman use "aliases" for images. F.ex. `hello-world` is a different image than used by Docker. In my personal opinion,
  this brings some uncertainty about which image I'm trying to run.
 
## Colima in brief
```shell
## Installation - see https://pet2cattle.com/2022/09/minikube-colima-macos-m1 and https://github.com/abiosoft/colima
brew install docker docker-compose # Note: this does not install the Docker Engine, just Docker CLI
mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
brew install colima

## Startup
colima start

## Usage
docker run hello-world:latest
docker ps
```
What's noteworthy:

 * :white_check_mark: it works
 * :x: no GUI/Desktop tool
 * :large_orange_diamond: a bit more difficult installation (but come on, it's just a natural consequence of using the Docker CLI)
 * :white_check_mark: uses the Docker CLI. All your automation scripts should work fine
 * :white_check_mark: there's no separate Colima driver for Minikube, but the Docker driver works just fine.
 * :white_check_mark: Colima is also not detected as a runtime environment for testcontainers, but there's an [official support](https://www.testcontainers.org/supported_docker_environment/#using-colima) for it and it only requires two env variables to be set
 * :white_check_mark: image registry is the same as in Docker

Moreover, colima has some other cool features, including:

* :white_check_mark: build-in kubernetes
* :white_check_mark: multi-architecture support (by CPU emulation) - see [this link](macos-running-amd64-images-on-apple-m1.md)

It's also worth mentioning, that there are [existing online reports](https://kumojin.com/en/colima-alternative-docker-desktop/) stating
that colima runs faster then the original Docker Desktop.

## Verdict: Colima is better
While both Podman and Colima works fine, **for me Colima is much better tool** due to better compatibility with other software.