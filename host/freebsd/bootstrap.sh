pkg install -y tmux virtualbox-ose-nox11 neovim vagrant


sysrc hostname="electrixx-gameserver"
sysrc keymap="de.kbd"
sysrc ifconfig_em0="inet 141.56.50.37 netmask 255.255.255.0"
sysrc defaultrouter="141.56.50.254"
sysrc ifconfig_igb0="10.56.50.1 netmask 255.255.255.0"
sysrc ifconfig_igb1="10.56.50.254 netmask 255.255.255.0"
sysrc sshd_enable="YES"
sysrc dumpdev="AUTO"
sysrc zfs_enable="YES"
sysrc dhcpd_enable="YES"
sysrc pf_enable="YES"
sysrc pf_rules="/etc/pf.conf"
sysrc pflog_enable="YES"
sysrc gateway_enable="YES"


### pf.conf
cat << EOPFCFG > /etc/pf.conf
ext_if="em0"
int0_if="igb0"
int1_if="igb1"
electrixx_net=$int1_if:network
#net51="$ext_if:141.56.51.0/24"

#pass in on $int1_if from $electrixx_net to $net51 keep state
#pass out on $ext_if from $electrixx_net to $net51 keep state
nat on $ext_if from $electrixx_net to any -> ($ext_if)
EOPFCFG

### dhcpd.conf

### VirtualBox setup
echo 'vboxdrv_load="YES"' | tee -a /boot/loader.conf

sysrc vboxnet_enable="YES"

pw groupmod vboxusers -m gamemaster

if [ "`grep -r vboxnetctl /etc/devfs.conf | wc -l`" -lt "2" ]
then
	echo "own     vboxnetctl root:vboxusers" | tee -a /etc/devfs.conf
	echo "perm    vboxnetctl 0660" | tee -a /etc/devfs.conf
fi

service devfs restart

