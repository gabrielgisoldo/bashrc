export SVN_EDITOR=/usr/bin/vim
export vPRIMARYMONITOR="DP1"
export vLOC="--left-of"
export vEXT=$(xrandr -q | grep " connected" | grep -v $vPRIMARYMONITOR | awk '{print $1}' | head -n 1 )
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
alias reboot='sudo shutdown -r now'
alias shutdown='sudo shutdown -h now'
alias rm='rm -fr'
alias rmd='sudo rm -fr'
alias h='history | grep $1'
alias cp='cp -v '
alias mv='mv -v'
alias which='type -all'
alias cd..='cd ..'
alias grepx='grep -Rlis'
alias free='df -h'
alias diffe='diff -iEZbaB'
alias zopestart='$ZOPE_ENV/zopectl start'
alias zopestop='$ZOPE_ENV/zopectl stop'
alias zoperes='$ZOPE_ENV/zopectl restart'
# alias svn_add="svn status | grep '?' | sed 's/^.* /svn add /' | bash"
alias count='ls -1 | wc -l'
alias sessionrm='find /tmp/sessions/. -mtime +0 -exec rm {} \;'
alias monitor='/usr/bin/xrandr --output $vEXT --auto $vLOC $vPRIMARYMONITOR'

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

# flatdir() { /home/gabriel/shell_scripts/flatdir.sh "$1" "$2" ; }

scpr() { scp -r "$1" "$2"192.168."$3":"$4" ; }

# criar video a partir de imagem e audio/video
# ffmpeg -loop 1 -y -i teste_img.png -i teste.mp4 -shortest result.mp4

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

