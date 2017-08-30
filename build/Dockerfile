FROM scratch
MAINTAINER Rom1 <rom1@canel.ch> - CANEL https:///www.canel.ch
ADD sid-chroot.tar /
RUN apt-get update \
	&& apt-get -y upgrade --no-install-recommends \
	&& apt-get -y autoremove --purge \
	&& apt-get clean \
	&& find /var/lib/apt/lists -type f -delete
CMD ["/bin/bash"]
