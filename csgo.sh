#! /bin/bash
STEAM_HOME=$HOME/server/steam
cd $STEAM_HOME
./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 +quit

mv $STEAM_HOME/csgo/csgo/cfg/server.cfg $STEAM_HOME/csgo/csgo/cfg/server.cfg.old

cat <<<"
sm plugins unload_all
sm plugins load_unlock
// pugsetup plugin activation
sm plugins load pugsetup.smx
sm plugins load_lock
hostname \"CSGO Server Elektrixx Epsilon\"
rcon_password \"geheim\"
mp_autoteambalance 0
bot_kick 1
tv_enable 1
tv_delay 120
tv_autorecord 1 // wird im csgo ordner unter <name der karte>.dem abgelegt
# den Rest löschen
" > $STEAM_HOME/csgo/csgo/cfg/server.cfg


cd $STEAM_HOME/csgo
wget -c http://www.sourcemod.net/smdrop/1.7/sourcemod-1.7.3-git5275-linux.tar.gz
tar xvfz sourcemod-1.7.3-git5275-linux.tar.gz
wget -c https://metamodsource.net/downloads/mmsource-1.10.6-linux.tar.gz/2
tar xvfz 2
wget -c https://github.com/splewis/csgo-pug-setup/releases/download/1.4.2/pugsetup_1.4.2.zip
unzip pugsetup_1.4.2.zip

echo -e "
vim addons/sourcemod/configs/pugsetup/maps.txt

TIP: # lösche de_nuke 2015-12-04

Server starten

 cd $HOME/steam/server/csgo
tmux
./srcds_run -game csgo -usercon -console -tickrate 64\
   +game_type 0 +game_mode 1 +map de_dust2 +exec server.cfg
"


