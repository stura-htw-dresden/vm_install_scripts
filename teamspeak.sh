#! /bin/bash
SERVER_HOME=$HOME/server
TEAMSPEAK_HOME=$SERVER_HOME/teamspeak
mkdir -p $TEAMSPEAK_HOME
cd $TEAMSPEAK_HOME

wget -c http://teamspeak.gameserver.gamed.de/ts3/releases/3.0.12.4/teamspeak3-server_linux_amd64-3.0.12.4.tar.bz2
tar xfvj teamspeak3-server_linux_amd64-3.0.12.4.tar.bz2

echo -e "
Start Server

./ts3server_minimal_runscript.sh createinifile=1
./ts3server_startscript.sh  start inifile=ts3server.ini
"
