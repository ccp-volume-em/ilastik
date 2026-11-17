ARG UBUNTU_VERSION=24.04
ARG ILASTIK_VERSION=1.4.2

FROM ubuntu:${UBUNTU_VERSION} AS download
ARG ILASTIK_VERSION
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget bzip2 ca-certificates \
    && wget -q -P /tmp https://files.ilastik.org/ilastik-${ILASTIK_VERSION}-Linux.tar.bz2 \
    && tar -xjf /tmp/ilastik-${ILASTIK_VERSION}-Linux.tar.bz2 -C /opt \
    && mv /opt/ilastik-* /opt/ilastik \
    && rm -rf /tmp/*.tar.bz2 /var/lib/apt/lists/*

FROM ubuntu:${UBUNTU_VERSION} AS ilastik
ARG UBUNTU_VERSION
ARG ILASTIK_VERSION
ARG DEBIAN_FRONTEND=noninteractive
ARG IMAGE_VERSION="${ILASTIK_VERSION}"
ARG IMAGE_REVISION=""
ARG IMAGE_CREATED=""

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgl1 libgl1-mesa-dri libglu1-mesa \
        libxcb-cursor0 libxkbcommon-x11-0 libxrender1 libxi6 libfontconfig1 \
        libdbus-1-3 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=download /opt/ilastik /opt/ilastik

ENV NUMBA_CACHE_DIR=/tmp/numba_cache \
    BIOIMAGEIO_CACHE_PATH=/tmp/pybio_cache \
    LIBGL_ALWAYS_SOFTWARE=1

LABEL org.opencontainers.image.title="RFI/CCP-volumeEM ilastik" \
      org.opencontainers.image.description="Ubuntu container with ilastik" \
      org.opencontainers.image.authors="The Rosalind Franklin Institute, The Collaborative Computational Project for Volume Electron Microscopy" \
      org.opencontainers.image.source="https://github.com/ccp-volume-em/ilastik" \
      org.opencontainers.image.documentation="https://rosalindfranklininstitute.github.io/volume-em-container-documentation/software/ilastik/" \
      org.opencontainers.image.licenses="GPL-3.0" \
      org.opencontainers.image.base.name="docker.io/library/ubuntu:${UBUNTU_VERSION}" \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.revision="${IMAGE_REVISION}" \
      org.opencontainers.image.created="${IMAGE_CREATED}" \
      uk.ac.rfi.ilastik.source="https://github.com/ilastik/ilastik"

ENTRYPOINT ["/opt/ilastik/run_ilastik.sh"]
