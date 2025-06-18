ARG KUBECTL_SLICE_VER=v1.4.2
ARG ALPINE_VERSION=3.22
ARG PYTHON_VERSON=3.13.5


FROM harbor.earth.nww/docker/alpine:${ALPINE_VERSION} AS build


ARG KUBECTL_SLICE_VER


RUN wget --tries=5 https://github.com/patrickdappollonio/kubectl-slice/releases/download/${KUBECTL_SLICE_VER}/kubectl-slice_linux_x86_64.tar.gz; \
  tar -x -f kubectl-slice_linux_x86_64.tar.gz; \
  chmod +x kubectl-slice;



FROM harbor.earth.nww/docker/python:${PYTHON_VERSON}-alpine${ALPINE_VERSION}


LABEL \
  org.opencontainers.image.author="No Fuss Computing" \
  org.opencontainers.image.vendor="No Fuss Computing" \
  org.opencontainers.image.title="kubectl-split and format" \
  org.opencontainers.image.description="Split a kubernetes manifest file into single manifests and format" \
  maintainer="No Fuss Computing" \
  io.artifacthub.package.license="MIT"


COPY --from=build /kubectl-slice /bin/kubectl-slice


ADD includes/ /


RUN \
  chmod +x /entrypoint.sh; \
  mv /bin/yaml-format.py /bin/yaml-format; \
  chmod +x /bin/yaml-format; \
  apk update --no-cache; \
  apk upgrade --no-cache; \
  pip install --no-cache-dir ruamel.yaml==0.18.14;


WORKDIR /workdir

ENTRYPOINT [ "/entrypoint.sh" ]
