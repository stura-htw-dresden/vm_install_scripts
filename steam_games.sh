#! /bin/bash
export STEAM_HOME=$HOME/server/steam
mkdir -p $STEAM_HOME
cd $STEAM_HOME
wget -c http://media.steampowered.com/client/steamcmd_linux.tar.gz
tar xfvz steamcmd_linux.tar.gz
