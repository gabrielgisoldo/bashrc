#!/bin/bash
last_char=$"${1: -1}"

if [ "$last_char" == "/" -a  ${#2} -gt 0 ]; then
    diretorio=$"${1}flatdir_files_${2//[^[:alnum:]]/}"
    mkdir "$diretorio"
elif [ ${#last_char} -gt 0  -a  ${#2} -gt 0 ]; then
    diretorio=$"${1}/flatdir_files_${2//[^[:alnum:]]/}"
    mkdir "$diretorio"
else
    echo "É necessário informar um diretorio e um filtro para o script."
    exit
fi

find "$1" -type f -iname "$2" -print0 | xargs -0 cp -t "$diretorio"

exit
