echo -e "All commands will be executed with sudo\n\n"

slackpkgplus=$(ls /var/log/packages | grep slackpkg+)
sbotools=$(ls /var/log/packages | grep sbotools)
slkupdt="0"
slkupdtgpg="0"
REPO_SLACK=""

# START: Update distro packages using slackpkg
read -p "Update packages from distro (s/n): " op
if [ "$op" == "s" ]; then
    if [ ${#slackpkgplus} -gt 0 ]; then
        sudo /usr/sbin/slackpkg update gpg
        slkupdtgpg="1"
    fi
    slkupdt="1"
    sudo /usr/sbin/slackpkg update
    sudo /usr/sbin/slackpkg install-new
    sudo /usr/sbin/slackpkg upgrade-all
fi
# END: Update distro packages using slackpkg

echo

# START: Update 32bits distro packages
read -p "Update 32 bits packages(s/n):" op
if [ "$op" == "s" ]; then
    sudo /usr/sbin/massconvert32.sh -u "${REPO_SLACK}"
    sudo /sbin/upgradepkg --install-new *-compat32/*.t?z
    sudo find /tmp/ -name '*-compat32' -maxdepth 1 -print | xargs sudo /usr/bin/rm -rf
fi
# END: Update 32bits distro packages

echo

# START: Update packages using SBO
if [ ${#sbotools} -gt 0 ]; then
    read -p "Check packages to update with SBO(s/n): " op
    if [ "$op" == "s" ]; then
        sudo /usr/sbin/sbocheck
        pkg=$(cat /var/log/sbocheck.log | awk '{print $1}' | tr '\n' ' ')
        echo
        if [ ${#pkg} -gt 0 ]; then 
            read -p "Update all packages (s/n): " att
            if [ "$att" == "s" ]; then
                sudo /usr/sbin/sboupgrade "${pkg}"
            else
                echo -e "\nPackages to update:\n\n${pkg}\n"
                read -p "Which packages to update(type '.' to exit): " pacote
                if [ "$pacote" != "." ]; then
                    sudo /usr/sbin/sboupgrade "${pacote}"
                else
                    echo
                fi
            fi
            sudo /usr/sbin/sboclean -w -d
            sudo /usr/bin/rm -f /var/log/sbocheck.log
            sudo touch /var/log/sbocheck.log
        else
            echo "There is no package to update."
        fi
    fi
fi
# END: Update packages using SBO
