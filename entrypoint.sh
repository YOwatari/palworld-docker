#!/bin/bash

if [ "${USER_ID}" -ne 0 ] && [ "${GROUP_ID}" -ne 0 ]; then
    usermod -o -u "${USER_ID}" ${USER}
    groupmod -o -g "${GROUP_ID}" ${USER}
else
    exit 1
fi

mkdir -p ${STEAMAPPDIR} || true
chown -R ${USER}:${USER} ${STEAMAPPDIR}

su ${USER} -c "${HOMEDIR}/steamcmd/steamcmd.sh +force_install_dir ${STEAMAPPDIR} +login anonymous +app_update ${STEAMAPPID} validate +quit"


CMD="${STEAMAPPDIR}/PalServer.sh"

if [ -n "${SERVER_PORT}" ]; then
    CMD="${CMD} port=${SERVER_PORT}"
fi

if [ -n "${SERVER_PLAYERS}" ]; then
    CMD="${CMD} players=${SERVER_PLAYERS}"
fi

CMD="${CMD} -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"

echo "${CMD}"
exec su ${USER} -c "${CMD}"

