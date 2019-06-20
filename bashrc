# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# proxy on
function proxy_on() {
  export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
  export http_proxy="http://127.0.0.1:12333"
  export https_proxy=$http_proxy
  echo -e "Proxy On"
}

# proxy off
function proxy_off() {
  unset http_proxy
  unset https_proxy
  unset no_proxy
  echo -e "Proxy Off"
}

# --------------------------------------------------------git alias
quickpush () {
    git add -A
    git commit -m "$1"
    git push
}
alias st='git status'
alias diff='git diff'
alias push='git push'
alias co='git checkout'
alias add='git add -A'
alias commit='git commit -m'
alias pull='git pull'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# --------------------------------------------------------git alias



stop_process () {
    echo "stop process of "$1
    _PID=`ps ufx | grep "$1" | awk '{print $2}'`
    echo "$_PID"|while read pid
    do
        if [ "$pid" != "" ]; then
            echo "kill process $pid"
            kill $pid
        else
            echo "No "$1" processes detected."
        fi
    done

    echo "Done."
}

