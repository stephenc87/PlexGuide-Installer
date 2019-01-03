#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################

# Add APT repos
apt-get install software-properties-common -y
add-apt-repository main
add-apt-repository universe
add-apt-repository restricted
add-apt-repository multiverse

# Upgrade
apt-get update -y

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  INSTALLING: PlexGuide Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
By Installing PlexGuide, you are agreeing to the terms and conditions
of the GNUv3 Project License! Please Standby...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
sleep 3

# Delete If it Exist for Cloning
file="/opt/plexguide"
if [ -e "$file" ]; then rm -rf /opt/plexguide; fi

file="/opt/pgstage"
if [ -e "$file" ]; then rm -rf /opt/pgstage; fi

apt-get install git -y
apt-get install zip -y
apt-get install unzip -y
rm -rf /opt/pgstage/place.holder 1>/dev/null 2>&1

git clone -b v8 --single-branch https://github.com/Admin9705/PlexGuide-Installer.git /opt/pgstage

mkdir -p /var/plexguide
echo "50" > /var/plexguide/pg.pythonstart
touch /var/plexguide/pg.pythonstart.stored
start=$(cat /var/plexguide/pg.pythonstart)
stored=$(cat /var/plexguide/pg.pythonstart.stored)

if [ "$start" != "$stored" ]; then
bash /opt/pgstage/pyansible.sh
fi
echo "50" > /var/plexguide/pg.pythonstart.stored

ansible-playbook /opt/pgstage/clone.yml
cp /opt/plexguide/menu/alias/templates/plexguide /bin/plexguide

apt-get install dialog -y

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Verifiying PlexGuide Installed @ /bin/plexguide - Please Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 2

file="/bin/plexguide"
if [ ! -e "$file" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! Installed Failed! PlexGuide Command Missing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Please Reinstall PlexGuide by running the Command Again! We are doing
this to ensure that your installation continues to work!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
exit
fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASSED! The PlexGuide Command Installed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
rm -rf /var/plexguide/new.install 1>/dev/null 2>&1
sleep 2
chmod 755 /bin/plexguide
chown 1000:1000 /bin/plexguide

## Other Folders
mkdir -p /opt/appdata/plexguide
mkdir -p /var/plexguide

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Start AnyTime By Typing >>> plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
