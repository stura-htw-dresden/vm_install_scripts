#! /bin/sh

STEAM_HOME=$HOME/server/steam
cd $STEAM_HOME

./steamcmd.sh +login anonymous +force_install_dir ./css +app_update 232330 +quit

