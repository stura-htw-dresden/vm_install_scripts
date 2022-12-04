#! /bin/bash

steamcmd +login anonymous +force_install_dir {{ CSGO_HOME }}/ +app_update 740 validate +quit
