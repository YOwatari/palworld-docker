#!/bin/bash

mkdir -p /palworld
chown -R ${USER}:${USER} /palworld

su steam -c "${HOMEDIR}/steamcmd/steamcmd.sh +force_install_dir /palworld +login anonymous +app_update 2394010 validate +quit"


CMD="/palworld/PalServer.sh"

if [ -n "${SERVER_PORT}" ]; then
    CMD="${CMD} port=${SERVER_PORT}"
fi

if [ -n "${SERVER_PLAYERS}" ]; then
    CMD="${CMD} players=${SERVER_PLAYERS}"
fi

CMD="${CMD} -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS"

echo "${CMD}"
su steam -c "${CMD}"

