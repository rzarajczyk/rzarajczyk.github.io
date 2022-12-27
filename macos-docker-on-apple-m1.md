# Docker on MacOS

## Part 1 - Docker without Docker Desktop

Since 2022, Docker Desktop is no longer free of change for companies above 250 employees.

While this is not a big deal if you're working on Linux (you can still use the official command line Docker),
it became a problem on MacOS, because there's no such thing as a standalone command line Docker - you have
to install Docker Desktop to get Docker from Docker.

However, there are free of charge alternatives:
 - [podman](https://podman.io/)
 - [colima](https://github.com/abiosoft/colima)

### Podman in brief
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
 * ✅ it works
 * ✅ Podman may be used together with the GUI tool: [Podman Desktop](https://podman-desktop.io/)
 * ✅ trivial installation
 * ❌ have it's own command line tool, which is very similar to docker (in fact Podman docs suggest creating an alias `alias docker=podman`),
  but not the same. If you use bash scripts for automating, they might be broken
 * ❌ Podman driver for Minikube is experimental. While it is possible to configure podman correctly for Minikube, it's not as easy as it might
  look like - default setup doesn't work, you need to experiment with parameters to have your Minikube cluster running (in short: rootful + containerd)
 * ❌ Podman is not detected as a runtime environment for testcontainers and there's no official support. Google says that it should be possible
  to have it working, but requires some more additional steps (ssh'ing into Podman VM and socket tunneling)
 * ❌ in some cases Podman use "aliases" for images. F.ex. `hello-world` is a different image than used by Docker. In my personal opinion,
  this brings some uncertainty about which image I'm trying to run.
  
### Colima in brief
```shell
## Installation - see https://pet2cattle.com/2022/09/minikube-colima-macos-m1 and https://github.com/abiosoft/colima
brew install docker docker-compose
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
 * ✅ it works
 * ❌ no GUI/Desktop tool
 * 🔶 a bit more difficult installation (but come on, it's just a natural consequence of using the Docker CLI)
 * ✅ uses the Docker CLI. All your automation scripts should work fine
 * ✅ there's no separate Colima driver for Minikube, but the Docker driver works just fine.
 * ✅ Colima is also not detected as a runtime environment for testcontainers, but there's an [official support](https://www.testcontainers.org/supported_docker_environment/#using-colima) for it and it only requires two env variables to be set
 * ✅ image registry is the same as in Docker

### Summary
While both Podman and Colima works fine, **for me Colima is much better tool** due to better compatibility with other software.
