## aliases ##############################################################

# general ---------------------------------------------------------------
alias desk="cd ~/Desktop"
alias ..="cd ../"
alias ...="cd ../../"

# List all files colorized in long format
alias l="ls"
# Show hidden files #
alias l.='ls -d .*'
alias ll="ls -l"
# List all files colorized in long format, including dot files
alias la="ls -la"
# List only directories
alias lsd='ls -l | grep "^d"'
# Always use color output for `ls`
if [[ "$OSTYPE" =~ ^darwin ]]; then
        alias ls="command ls -G"
else
        alias ls="command ls --color"
        export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

alias c='pygmentize -O style=monokai -f console256 -g'
# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
# Start calculator with math support #
alias bc='bc -l'
alias now='date +"%T'
# list all TCP/UDP port on the server #
alias ports='netstat -tulanp'
alias tree="find . -print | sed -e 's;[^/]*/;|--;g;s;--|;   |;g'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

alias o="open"
alias oo="open ."

# Applications ----------------------------------------------------------
alias xcode="open -a '/Applications/XCode.app'"
alias firefox="open -a firefox"
alias chrome="open -a google\ chrome"


# IP addresses ----------------------------------------------------------
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# git alises ------------------------------------------------------------
alias gs="git status"
alias gb="git branch"
alias gbl="git branch --list"
alias log1="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias log2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias undopush="git push -f origin HEAD^:master"
alias gdev="git checkout develop"
alias gmas="git checkout master"
alias gcam="git commit -a -m"
alias gcm="git commit -m"
alias gc="git commit"
alias gch="git checkout"


# web server aliases ----------------------------------------------------
alias amppsStart="sudo /Applications/AMPPS/apache/bin/httpd -k start"
alias amppsStop="sudo /Applications/AMPPS/apache/bin/httpd -k stop"
alias amppsRestart="sudo /Applications/AMPPS/apache/bin/httpd -k restart"


# shell fuctions --------------------------------------------------------
function changelog(){
  git log $1..HEAD --pretty=format:'- %s'
}

# custom build commands ---
function theme-build(){
  DIRNAME=${PWD};
  FOLDERNAME=${PWD##*/};
  cp -r $DIRNAME ~/Desktop/$FOLDERNAME;
  cd ~/Desktop/$FOLDERNAME; 
  rm -rf .git;
  rm -rf .gitignore;
  rm -rf languages/fa_IR.po;
  rm -rf languages/fa_IR.mo;
  rm -rf css/rtl.css;
  echo "built sucessfully done!";
}

function tab() {
  about 'opens a new terminal tab'
  group 'osx'

  osascript 2>/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "t" using command down
    end
    tell application "Terminal"
      activate
      do script with command " cd \"$PWD\"; $*" in window 1
    end tell
EOF
}

extract () {
  if [ $# -ne 1 ]
  then
    echo "Error: No file specified."
    return 1
  fi
        if [ -f $1 ] ; then
                case $1 in
                        *.tar.bz2) tar xvjf $1   ;;
                        *.tar.gz)  tar xvzf $1   ;;
                        *.bz2)     bunzip2 $1    ;;
                        *.rar)     unrar x $1    ;;
                        *.gz)      gunzip $1     ;;
                        *.tar)     tar xvf $1    ;;
                        *.tbz2)    tar xvjf $1   ;;
                        *.tgz)     tar xvzf $1   ;;
                        *.zip)     unzip $1      ;;
                        *.Z)       uncompress $1 ;;
                        *.7z)      7z x $1       ;;
                        *)         echo "'$1' cannot be extracted via extract" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}



z() {
 local datafile="$HOME/.z"
 if [ "$1" = "--add" ]; then
  # add
  shift
  # $HOME isn't worth matching
  [ "$*" = "$HOME" ] && return
  awk -v p="$*" -v t="$(date +%s)" -F"|" '
   BEGIN { rank[p] = 1; time[p] = t }
   $2 >= 1 {
    if( $1 == p ) {
     rank[$1] = $2 + 1
     time[$1] = t
    } else {
     rank[$1] = $2
     time[$1] = $3
    }
    count += $2
   }
   END {
    if( count > 1000 ) {
     for( i in rank ) print i "|" 0.9*rank[i] "|" time[i] # aging
    } else for( i in rank ) print i "|" rank[i] "|" time[i]
   }
  ' "$datafile" 2>/dev/null > "$datafile.tmp"
  mv -f "$datafile.tmp" "$datafile"
 elif [ "$1" = "--complete" ]; then
  # tab completion
  awk -v q="$2" -F"|" '
   BEGIN {
    if( q == tolower(q) ) nocase = 1
    split(substr(q,3),fnd," ")
   }
   {
    if( system("test -d \"" $1 "\"") ) next
    if( nocase ) {
     for( i in fnd ) tolower($1) !~ tolower(fnd[i]) && $1 = ""
     if( $1 ) print $1
    } else {
     for( i in fnd ) $1 !~ fnd[i] && $1 = ""
     if( $1 ) print $1
    }
   }
  ' "$datafile" 2>/dev/null
 else
  # list/go
  while [ "$1" ]; do case "$1" in
   -h) echo "z [-h][-l][-r][-t] args" >&2; return;;
   -l) local list=1;;
   -r) local typ="rank";;
   -t) local typ="recent";;
   --) while [ "$1" ]; do shift; local fnd="$fnd $1";done;;
    *) local fnd="$fnd $1";;
  esac; local last=$1; shift; done
  [ "$fnd" ] || local list=1
  # if we hit enter on a completion just go there
  [ -d "$last" ] && cd "$last" && return
  [ -f "$datafile" ] || return
  local cd="$(awk -v t="$(date +%s)" -v list="$list" -v typ="$typ" -v q="$fnd" -v tmpfl="$datafile.tmp" -F"|" '
   function frecent(rank, time) {
    dx = t-time
    if( dx < 3600 ) return rank*4
    if( dx < 86400 ) return rank*2
    if( dx < 604800 ) return rank/2
    return rank/4
   }
   function output(files, toopen, override) {
    if( list ) {
     if( typ == "recent" ) {
      cmd = "sort -nr >&2"
     } else cmd = "sort -n >&2"
     for( i in files ) if( files[i] ) printf "%-10s %s\n", files[i], i | cmd
     if( override ) printf "%-10s %s\n", "common:", override > "/dev/stderr"
    } else {
     if( override ) toopen = override
     print toopen
    }
   }
   function common(matches, fnd, nc) {
    for( i in matches ) {
     if( matches[i] && (!short || length(i) < length(short)) ) short = i
    }
    if( short == "/" ) return
    for( i in matches ) if( matches[i] && i !~ short ) x = 1
    if( x ) return
    if( nc ) {
     for( i in fnd ) if( tolower(short) !~ tolower(fnd[i]) ) x = 1
    } else for( i in fnd ) if( short !~ fnd[i] ) x = 1
    if( !x ) return short
   }
   BEGIN { split(q, a, " ") }
   {
    if( system("test -d \"" $1 "\"") ) next
    print $0 >> tmpfl
    if( typ == "rank" ) {
     f = $2
    } else if( typ == "recent" ) {
     f = t-$3
    } else f = frecent($2, $3)
    wcase[$1] = nocase[$1] = f
    for( i in a ) {
     if( $1 !~ a[i] ) delete wcase[$1]
     if( tolower($1) !~ tolower(a[i]) ) delete nocase[$1]
    }
    if( wcase[$1] > oldf ) {
     cx = $1
     oldf = wcase[$1]
    } else if( nocase[$1] > noldf ) {
     ncx = $1
     noldf = nocase[$1]
    }
   }
   END {
    if( cx ) {
     output(wcase, cx, common(wcase, a, 0))
    } else if( ncx ) output(nocase, ncx, common(nocase, a, 1))
   }
  ' "$datafile")"
  if [ $? -gt 0 ]; then
   rm -f "$datafile.tmp"
  else
   mv -f "$datafile.tmp" "$datafile"
   [ "$cd" ] && cd "$cd"
  fi
 fi
}
# tab completion
complete -C 'z --complete "$COMP_LINE"' z
# populate directory list. avoid clobbering other PROMPT_COMMANDs.
echo $PROMPT_COMMAND | grep -q "z --add"
[ $? -gt 0 ] && PROMPT_COMMAND='z --add "$(pwd -P)";'"$PROMPT_COMMAND"



# Sexy Bash Prompt, inspired by "Extravagant Zsh Prompt"
# Screenshot: http://cloud.gf3.ca/M5rG
# A big thanks to \amethyst on Freenode
# https://github.com/revans/bash-it/blob/master/themes

if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then export TERM=gnome-256color
elif [[ $TERM != dumb ]] && infocmp xterm-256color >/dev/null 2>&1; then export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 0)
    else
      MAGENTA=$(tput setaf 5)
      ORANGE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      PURPLE=$(tput setaf 1)
      WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -n1 | cut -c 1-17) != "nothing to commit" ]] && echo "*"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function prompt_command() {
  PS1="╭── \[${BOLD}${MAGENTA}\]\u \[$WHITE\]at \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n╰─> \[$RESET\]"
}

PROMPT_COMMAND=prompt_command
