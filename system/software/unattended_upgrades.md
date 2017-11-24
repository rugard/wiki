Check:

/usr/local/sbin/customscripts/utils/apt-check

Install:

/usr/local/sbin/customscripts/utils/apt-check 2>/dev/null | xargs sudo apt-get install --reinstall -o Dpkg::Options::="--force-confold" --force-yes -y
