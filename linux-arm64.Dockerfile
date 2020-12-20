FROM ghcr.io/burningio/base@sha256:f3b57720f7db4a31c893cc866fd348158d0e127fe3c462c2386d7bbbc23a8bd0

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
