FROM hotio/base

ARG DEBIAN_FRONTEND="noninteractive"

# install packages
# https://download.mono-project.com/repo/ubuntu/dists/bionic/main/binary-amd64/Packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5CDF62C7AE05CC847657390C10E11090EC0E438 && echo "deb https://mediaarea.net/repo/deb/ubuntu bionic main" | tee /etc/apt/sources.list.d/mediaarea.list && \
    apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        libcurl4-openssl-dev \
        mono-devel=5.20.1.19-0xamarin2+ubuntu1804b1 \
        sqlite3 \
        mediainfo && \
# clean up
    apt purge -y gnupg && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
