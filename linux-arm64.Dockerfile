FROM ghcr.io/hotio/base@sha256:67bee4a2ed7179a7957ef1d01515754dd7fd09b19b127bd27d9b65f10c9d30a7

ARG DEBIAN_FRONTEND="noninteractive"

# https://download.mono-project.com/repo/ubuntu/dists/focal/snapshots/
ARG MONO_VERSION=6.10.0.104

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && echo "deb https://download.mono-project.com/repo/ubuntu focal/snapshots/${MONO_VERSION} main" | tee /etc/apt/sources.list.d/mono-official.list && \
    apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        mono-complete=${MONO_VERSION}\* \
        libmediainfo0v5 && \
# clean up
    apt purge -y gnupg && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
