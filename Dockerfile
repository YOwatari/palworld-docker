FROM cm2network/steamcmd:root AS build

ENV STEAMAPPID 2394010
ENV STEAMAPP palworld

RUN \
    --mount=type=cache,target=/var/cache/apt \
    apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget=1.21-1+deb11u1 \
        ca-certificates=20210119 \
        lib32z1=1:1.2.11.dfsg-2+deb11u2

COPY entrypoint.sh "${HOMEDIR}/entrypoint.sh"

RUN chmod +x "${HOMEDIR}/entrypoint.sh" \
    && chown -R "${USER}:${USER}" "${HOMEDIR}/entrypoint.sh"

FROM build as base

ENV SERVER_PORT=8211 \
    SERVER_PLAYERS=32

WORKDIR ${HOMEDIR}

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 8211/udp

