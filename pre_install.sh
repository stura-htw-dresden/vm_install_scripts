#! /bin/bash
dpkg --add-architecture i386
apt-get update
apt-get install libx11-6:i386 libxext6:i386 libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 tmux mailutils postfix ca-certificates lib32gcc1 libstdc++6 libstdc++6:i386 curl winbind

