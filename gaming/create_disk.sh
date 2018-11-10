set -e
set -x

if [ -f /etc/provision_env_disk_added_date ]
then
    echo "Provision runtime already done."
    exit 0
fi


sudo fdisk -u /dev/sdb <<EOF
n
p
1



w
EOF

date > /etc/provision_env_disk_added_date
