**!! THIS IS A FORK OF <a href="https://github.com/jmtd/debian-docker/">jmtd/debian-docker</a> !!**

# debian-docker

scripts and Dockerfiles to build Debian docker images

## Description of images

 * **stretch**: a base debian installation of stretch (current *stable*).
   Approx. 136M in size

 * **jessie**: a base debian installation of *jessie*.
   Approx. 156M in size.

## Getting started

To build your own images run

```bash
sudo apt-get install git make debootstrap
git clone https://github.com/canelrom1/debian-docker.git
cd debian-docker/
sudo make release=stretch prefix=canelrom1 arch=amd64 variant=minbase mirror=http://httpredir.debian.org/debian/
```

All the arguments above are optional. The values in the example above are
the defaults. The resulting image would be tagged `canelrom1/debian:stretch-amd64`.


---
Forker — Rom1 <rom1@canel.ch> - CANEL https://www.canel.ch

Original — Jonathan Dowland <jmtd@debian.org>
