# Running docker `amd64` images on Apple Silicon M1/M2 chip

Apple Silicon M1/M2 chips use the `arm64` (a.k.a `aarch64`) architecture. This makes them different from the Intel chips, which are
designed in `amd64` (a.k.a `x86_64`) architecture. Docker itself is a tool for virtualization, not emulation - it can create abstraction
of the operating system, but cannot emulate different CPU.

Docker images can contain different binaries for different architectures - but the publisher must intentionally append them to the image.
Sometimes they do it, sometimes they don't.

![macos-dockerhub-architectures.png](resources/macos-dockerhub-architectures.png)

So now the question is: **how to run `amd64` image on Apple M1?**

## Best Option: use different image

This is really the easiest and best solution. Most of the well-known software comes in different images from different publishers,
if you can't run one on them - just use others.

## (Not an) Option 2: wait till Rosetta support is there

Well this is not a real option, but there's an issue
[https://github.com/docker/roadmap/issues/384](https://github.com/docker/roadmap/issues/384) to add the Apple's
[Rosetta 2](https://en.wikipedia.org/wiki/Rosetta_(software)) emulator for Docker Desktop for Mac. But it's just an open
issue, no commitments have been made.

## Option 3: use CPU-emulation and install it on a virtual machine

Use the [UTM](https://mac.getutm.app/) virtual machine manager for MacOS, create a virtual machine in **emulation** mode,
install Ubuntu Server on it and run your image there. This works, but:

* the performance is poor. Like a really, really poor.
* your software will run on a virtual machine, so you need to manually take care of port forwarding of all your required ports to your VM
  (not only typical docker port exposing, but also forwarding ports to the VM)
* sharing a folder with the VM using UTM is requires installing additional tools in the guest system and non-trivial setup
