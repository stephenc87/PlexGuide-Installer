#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
# Setting variables
PREFIX=/usr

tee <<-MSG-NOTICE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  INSTALLING: PlexGuide Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
By Installing PlexGuide, you are agreeing to the terms and conditions
of the GNUv3 Project License! Please Standby...
Depends on git, zip, unzip, dialog, docker, python-docker and 
python-backports.ssl-match-hostname
WARNING
Please make sure these are installed before continuing, old copies of
plexguide will be deleted and new copy will be installed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MSG-NOTICE
read -rsn1 -p"Press any key to continue or Ctrl-C to cancel";echo

# remove any old files
rm -rf /opt/plexguide  1>/dev/null 2>&1
rm -rf /opt/pgstage  1>/dev/null 2>&1

# Keeping things up to date
git clone -b v8 --single-branch https://github.com/Admin9705/PlexGuide-Installer.git /opt/pgstage

# initialize some paths
mkdir -p /var/plexguide/logs
mkdir -p /opt/appdata/plexguide

# what is this?
  echo "50" > /var/plexguide/pg.pythonstart
  touch /var/plexguide/pg.pythonstart.stored
  start=$(cat /var/plexguide/pg.pythonstart)
  stored=$(cat /var/plexguide/pg.pythonstart.stored)

if [ "$start" != "$stored" ];
  then
    bash /opt/pgstage/pyansible.sh
fi

echo "50" > /var/plexguide/pg.pythonstart.stored

ansible-playbook /opt/pgstage/clone.yml
cp /opt/plexguide/menu/alias/templates/plexguide $PREFIX/sbin/plexguide


tee <<-MSG-VERIFY

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Verifiying PlexGuide Installed @ $PREFIX/sbin/plexguide - Please Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MSG-VERIFY

file="$PREFIX/sbin/plexguide"
if [ ! -e "$file" ]; then
  tee <<-MSG-FAIL

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! Installed Failed! PlexGuide Command Missing!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Please Reinstall PlexGuide by running the Command Again! We are doing
this to ensure that your installation continues to work!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MSG-FAIL
  exit
fi

tee <<-MSG-install

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASSED! The PlexGuide Command Installed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MSG-INSTALLED
# cleaning up
rm -rf /var/plexguide/new.install 1>/dev/null 2>&1

# setting permissions
chmod 755 $PREFIX/sbin/plexguide
chown 1000:1000 $PREFIX/sbin/plexguide

tee <<-MSG-COMPLETE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Start AnyTime By Typing >>> sudo plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MSG-COMPLETE
