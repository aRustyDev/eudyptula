FROM ubuntu:latest
ARG KERNVER=6.11.0-25-generic
RUN apt-get update && apt-get upgrade
RUN apt-get install -y make kmod dwarves gcc linux-headers-${KERNVER}
# RUN apt-get install -y "linux-headers-$(uname -r)"
# VOLUME /lib/modules:/lib/modules
COPY helloworld.c Makefile /app/
WORKDIR /app
# ENTRYPOINT [ "make" ]
