#! /bin/bash
export SERVER_HOME=$HOME/server
DODS_HOME=$SERVER_HOME/dods
mkdir -p $DODS_HOME
cd $DODS_HOME

wget -c http://gameservermanagers.com/dl/dodsserver
chmod +x dodsserver
./dodsserver install

echo -e "
Server starten

Fals mehrer IP Adressen vorhanden sind muss in, der Script Datei die IP gesetzt werden.

$ vim dodsserver
ip=\"yourtip\"

Zum starten:

$ ./dodsserver start
"
