echo -e "Os comandos serão executados como root\n\n"

# INICIO: Atualizar os pacotes da distro usando o slackpkg
read -p "Atualizar pacotes do rep. Slackware 14.2 (s/n): " op
if [ "$op" == "s" ]; then
    su - root -c "slackpkg update"
    su - root -c "slackpkg install-new"
    su - root -c "slackpkg upgrade-all"
fi
# FIM: Atualizar os pacotes da distro usando o slackpkg

echo

# INICIO: Atualizar os pacotes de 32 bits
read -p "Atualizar pacotes 32 bits (s/n): " op
if [ "$op" == "s" ]; then
    su - root -c "massconvert32.sh -u http://192.168.1.52/pub/Linux/Slackware/slackware-14.2/slackware"
    su - root -c "upgradepkg --install-new *-compat32/*.t?z"
    su - root -c "rm -rf *-compat32"
fi
# FIM: Atualizar os pacotes de 32 bits

echo

# INICIO: Atualizar pacotes usando SBO
read -p "verificar pacotes com o SBO(s/n): " op
if [ "$op" == "s" ]; then
    su - root -c "sbocheck"
    pkg=$(cat /var/log/sbocheck.log | awk '{print $1}' | tr '\n' ' ')
    echo
    if [ ${#pkg} -gt 0 ]; then 
        read -p "Atualizar todos os pacotes (s/n): " att
        if [ "$att" == "s" ]; then
            su - root -c "sboupgrade $pkg"
        else
            echo -e "\nPacotes para atualizar:\n\n${pkg}\n"
            read -p "Digite o nome do pacote ou . para sair: " pacote
            if [ "$pacote" != "." ]; then
                su - root -c "sboupgrade $pacote"
            else
                echo
            fi
        fi
        su - root -c "> /var/log/sbocheck.log"
    else
        echo "Nenhum pacote para atualizar."
    fi
fi
# FIM: Atualizar pacotes usando SBO
