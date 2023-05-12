Gameserver Install playbooks
============================

## Dialin via pppoe

* sudo pppoeconf UPLINK_INTERFACE

## interfaces

Bevor gestartet werdebn kann muessen die interfaces konfiguriert werden , mit den passenden IP adressen.

im  Verzeichnis __${HOME}/Dokumente__ liegt das script __activate_ipforwarding.sh__ um nach dem neustart die ip forwarding rule wieder zu initialisieren.

## run ansible playbooks

    1. ansible-playbook prepare.yml
    2. ansible-playbook dhcpd.yml
    3. ansible-playbook ufw.yml
    4. ansible-playbook steam_games.yml
       - als gamemaster rennen lasssen
    5. ansible-playbook mumble.yml
