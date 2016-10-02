#! /bin/bash
export SERVER_HOME=$HOME/server
QUAKE3_HOME=$SERVER_HOME/quake3

mkdir -p $QUAKE3_HOME
cd $QUAKE3_HOME

wget -c ftp://ftp.idsoftware.com/idstuff/quake3/linux/linuxq3apoint-1.32b-3.x86.run
chmod a+x linuxq3apoint-1.32b-3.x86.run
./linuxq3apoint-1.32b-3.x86.run --keep

echo -e "
Installation

https://wiki.stura.htw-dresden.de/index.php/Server/Quake3#Installation

cp /home/upload/Quake3/pak0.pk3 ./baseq3

Server starten

Starte den Server

$ ./quake3

"
