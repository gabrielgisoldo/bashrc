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
      echo "'$1' Cant be extracted."
      return 1
      ;;
    esac
  else
    echo "'$1' Not a valid file."
    return 1
  fi
  return 0
}

# Order of inputs: Folder to be used as base, filter of file to be searched.
flatdir() { /path/to/flatdir.sh "$1" "$2" ; }

# Order of inputs: Origin folder, user on remote machine, two last parts of the remote IP, Folder on remote machine.
scpr() { scp -r "$1" "$2"@192.168."$3":"$4" ; }

# Inputs: name of the video to be converted.
conv_video() { ffmpeg -i "$1" -c:v libx264 -preset ultrafast "$1" ; }

# Ordem dos inputs: name of the image to be used as poster, name of the audio file to be used with the image.
gerar_video() { ffmpeg -loop 1 -i "$1" -i "$2" -c:v libx264 -c:a aac -strict experimental -b:a 192k -shortest $"novo-${2}" ; }

# Replace substring inside of a file
# sed -i -e 's/SUBSTRING_TO_BE_REPLACED/SUBSTRING_THAT_WILL_REPLACE/g' FILE_TARGETED

# Rename the file
# rename EXPRESSION_TO_BE_CHANGED EXPRESSION_THAT_WILL_REPLACE FILES_TO_BE_CHANGED

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
