echo -e "All commands will be executed as root\n\n"

slackpkgplus=$(ls /var/log/packages | grep slackpkg+)
sbotools=$(ls /var/log/packages | grep sbotools)
slkupdt="0"
slkupdtgpg="0"

# START: Update distro packages using slackpkg
read -p "Update packages from distro (s/n): " op
if [ "$op" == "s" ]; then
    if [ ${#slackpkgplus} -gt 0 ]; then
        su - root -c "slackpkg update gpg"
        slkupdtgpg="1"
    fi
    slkupdt="1"
    su - root -c "slackpkg update"
    su - root -c "slackpkg install-new"
    su - root -c "slackpkg upgrade-all"
fi
# END: Update distro packages using slackpkg

echo

# START: Update 32bits distro packages
read -p "Update 32 bits packages(s/n):" op
if [ "$op" == "s" ]; then
    su - root -c "massconvert32.sh -u REPOSITORIO_SLACK"
    su - root -c "upgradepkg --install-new *-compat32/*.t?z"
    su - root -c "rm -rf *-compat32"
fi
# END: Update 32bits distro packages

echo

# START: Update packages using SBO
if [ ${#sbotools} -gt 0 ]; then
    read -p "Check packages to update with SBO(s/n): " op
    if [ "$op" == "s" ]; then
        su - root -c "sbocheck"
        pkg=$(cat /var/log/sbocheck.log | awk '{print $1}' | tr '\n' ' ')
        echo
        if [ ${#pkg} -gt 0 ]; then 
            read -p "Update all packages (s/n): " att
            if [ "$att" == "s" ]; then
                su - root -c "sboupgrade $pkg"
            else
                echo -e "\nPackages to update:\n\n${pkg}\n"
                read -p "Which packages to update(type '.' to exit): " pacote
                if [ "$pacote" != "." ]; then
                    su - root -c "sboupgrade $pacote"
                else
                    echo
                fi
            fi
            su - root -c "> /var/log/sbocheck.log"
        else
            echo "There is no package to update."
        fi
    fi
fi
# END: Update packages using SBO
