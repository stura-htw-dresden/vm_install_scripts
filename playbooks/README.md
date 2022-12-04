Gameserver Install playbooks
============================

## Dialin via pppoe

* sudo pppoeconf UPLINK_INTERFACE

## run ansible playbooks

    1. ansible-playbook prepare.yml
    2. ansible-playbook dhcpd.yml
    3. ansible-playbook ufw.yml
    4. ansible-playbook steam_games.yml
    5. ansible-playbook mumble.yml
