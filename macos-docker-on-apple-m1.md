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
brew install docker docker-compose # Note: it does not install the Docker Engine, just Docker CLI
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

### Verdict
While both Podman and Colima works fine, **for me Colima is much better tool** due to better compatibility with other software.

# Part 2 - running `amd64` images on Apple Silicon M1/M2 chip
Apple Silicon M1/M2 chips use the `arm64` (a.k.a `aarch64`) architecture. This makes them different from the Intel chips, which are
designed in `amd64` (a.k.a `x86_64`) architecture. Docker itself is a tool for virtualization, not emulation - it can create abstraction
of the operating system, but cannot emulate different CPU.

Docker images can contain different binaries for different architectures - but the publisher must intentionally append them to the image.
Sometimes they do it, sometimes they don't.

So now the question is: **how to run `amd64` image on Apple M1?**

### Best Option: use different image

This is realy the easiest and best solution. Most of the well-known software comes in different images from different publishers,
if you can't run one on them - just use others.

### (Not an) Option 2: wait till Rosetta support is there

Well this is not a real option, but there's an issue [https://github.com/docker/roadmap/issues/384](https://github.com/docker/roadmap/issues/384)
do add the Apple's [Rosetta 2](https://en.wikipedia.org/wiki/Rosetta_(software)) emulator for Docker Desktop for Mac. But it's just an open
issue, no commitments have been made.

### Option 3: use CPU-emulation and install it on a virtual machine

Use the [UTM](https://mac.getutm.app/) virtual machine manager for MacOS, create a virtual machine in **emulation** mode,
install Ubuntu Server on it and run your image there. This works, but:

 * the performance is poor. Like a really, really poor.
 * your software will run on a virtual machine, so you need to manually take care of port forwarding of all your required ports to your VM
  (not only typical docker port exposing, but also forwarding ports to the VM)
 * sharing a folder with the VM using UTM is requires installing additional tools in the guest system and non-trivial setup
