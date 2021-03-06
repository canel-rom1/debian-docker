#!/usr/bin/make
# USAGE: 'sudo make' to build a jessie image (jmtd/debian:jessie).
# Define variables on the make command line to change behaviour
# e.g.
#       sudo make release=wheezy arch=i386 tag=wheezy-i386

# variables that can be overridden:

name    ?= canel
prefix  ?= canelrom1
release ?= buster
arch    ?= amd64
tag     ?= $(release)-$(version)
version ?= $(shell date +%y.%m.%d)
mirror  ?= http://ftp.ch.debian.org/debian/
variant ?= minbase
description ?= Image de base de Debian $(release) $(arch) - $(variant)
packets ?=

all_packets=ca-certificates,curl,dirmngr,gnupg,procps,wget,$(packets)

dir_ = ./rootfs
rev=$(shell git rev-parse --verify HEAD)
date=$(shell date +%d\\/%m\\/%y)

all: build

build: $(dir_)/rootfs.tar $(dir_)/Dockerfile
	docker build -t $(prefix)/debian-$(name):$(tag) $(dir_)
	docker tag $(prefix)/debian-$(name):$(tag) $(prefix)/debian-$(name):$(release)
	docker tag $(prefix)/debian-$(name):$(tag) $(prefix)/debian-$(name):latest

$(dir_):
	mkdir -p $@

$(dir_)/Dockerfile: Dockerfile.in $(dir_)
	cp $< $@
	sed -i "s/date=\"\"/date=\"$(date)\"/" $@
	sed -i "s/version=\"\"/version=\"$(tag)\"/" $@
	sed -i "s/description=\"\"/description=\"$(description)\"/" $@

$(dir_)/rootfs.tar: $(dir_)/$(release)
	cd $(dir_)/$(release) && tar -c --numeric-owner -f ../rootfs.tar ./

$(dir_)/$(release): $(dir_)/Dockerfile
	mkdir -p $@
	chmod 755 $@
	debootstrap --arch=$(arch) --include=$(all_packets) --variant=$(variant) $(release) $@ $(mirror)
	chroot $@ apt-get clean

push:
	docker push $(prefix)/debian-$(name):$(tag)
	docker push $(prefix)/debian-$(name):$(release)
	docker push $(prefix)/debian-$(name):latest

clean-docker:
	docker rmi $(prefix)/debian-$(name):$(tag)

clean:
	rm -fr $(dir_)/$(release)
	rm -f $(dir_)/Dockerfile
	rm -f $(dir_)/rootfs.tar
	rmdir $(dir_)

.PHONY: clean build
