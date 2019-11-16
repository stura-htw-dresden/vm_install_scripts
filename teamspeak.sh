#! /bin/bash
SERVER_HOME=$HOME/server
TEAMSPEAK_HOME=$SERVER_HOME/teamspeak
mkdir -p $TEAMSPEAK_HOME
cd $TEAMSPEAK_HOME

wget -c https://files.teamspeak-services.com/releases/server/3.10.0/teamspeak3-server_linux_amd64-3.10.0.tar.bz2
tar xfvj teamspeak3-server_linux_amd64-3.10.0.tar.bz2

echo -e "
Start Server

./ts3server_minimal_runscript.sh createinifile=1
./ts3server_startscript.sh  start inifile=ts3server.ini
"
