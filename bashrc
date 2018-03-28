export LESS="-rM"

IP=$(/sbin/ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
export IP

fortune -o;

export PS1="\u@[\w]:~> "

alias l='ls -CF'
alias ls='ls -hF --color'    # add colors for filetype recognition
alias lx='ls -lXB'        # sort by extension
alias lk='ls -lSr'        # sort by size
alias la='ls -Al'        # show hidden files
alias lr='ls -lR'        # recursice ls
alias lt='ls -ltr'        # sort by date
alias lm='ls -al |more'        # pipe through 'more'
alias ll='ls -l'        # long listing
alias lsize='ls --sort=size -lhr' # list by size
alias lsd='ls -l | grep "^d"'   #list only directories
alias lalf='ls -alF'
alias p='python -W ignore'
alias rm='rm -r'
alias h='history | grep $1'
alias cp='cp -v '
alias mv='mv -v'
alias which='type -all'
alias cd..='cd ..'
alias grepx='grep -Rlis'
alias free='df -h'
alias diffe='diff -iEZbaB'
alias count='ls -1 | wc -l'

mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
mk7z() { 7za e  "${1%%/}.7z"     "${1%%/}/"; }

extract() {    
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2) tar xvjf "$1"   ;;
      *.tar.gz)  tar xvzf "$1"   ;;
      *.bz2)     bunzip2 "$1"    ;;
      *.rar)     unrar x "$1"    ;;
      *.gz)      gunzip "$1"     ;;
      *.tar)     tar xvf "$1"    ;;
      *.tbz2)    tar xvjf "$1"   ;;
      *.tgz)     tar xvzf "$1"   ;;
      *.zip)     unzip "$1"      ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7za e "$1"       ;;
      *)
      echo "'$1' Nao pode ser extraido."
      return 1
      ;;
    esac
  else
    echo "'$1' Nao eh um arquivo valido."
    return 1
  fi
  return 0
}

# Ordem dos inputs: Pasta a ser usada como base, tipo de arquivo a ser buscado.
flatdir() { /path/to/flatdir.sh "$1" "$2" ; }

# Ordem dos inputs: Pasta origem, usuario da maquina destino, fim do ip da maquina destino, pasta destino dentro da maquina.
scpr() { scp -r "$1" "$2"@192.168."$3":"$4" ; }

conv_video() { ffmpeg -i "$1" -c:v libx264 -preset ultrafast "$1" ; }

gerar_video() { ffmpeg -loop 1 -i "$1" -i "$2" -c:v libx264 -c:a aac -strict experimental -b:a 192k -shortest $"novo-${2}" ; }

enviar_email() {
  echo "$1" | mailx -r "gabriel.gisoldo@nube.com.br" -s "$2" -S smtp-auth-user=$1 -S smtp-auth-password=$2 $3 ;
}

# substituir substring dentro de um arquivo
# sed -i -e 's/SUBSTRING_A_SUBSTITUIR/SUBSTRING_QUE_VAI_SUBSTITUIR/g' ARQUIVO_A_SER_USADO

# Renomer arquivos sem usar MV
# rename O_QUE_MUDAR_NO_NOME_DO_ARQUIVO O_QUE_COLOCAR_NO_LUGAR QUAIS_ARQUIVOS_A_RENOMEAR

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
