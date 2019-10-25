                                                                                                        # If you come from bash you might have to change your $PATH.
ZSH_THEME="random" # (...please let it be pie... please be some pie..)

plugins=(
    git
    docker
    )

# --------------------------------------------------------git alias
function quickpush () {
    git add -A
    git commit -m "$1"
    git pull --rebase
    git push
}

alias st='git status'
alias df='git diff'
alias push='git push'
alias co='git checkout'
alias add='git add -A'
alias commit='git commit -m'
alias pull='git pull --rebase'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# --------------------------------------------------------git alias

alias aliyun='ssh root@luxuze.club'

export GOPROXY=https://goproxy.io

function proxyon {
    export https_proxy=http://127.0.0.1:6152
    export http_proxy=http://127.0.0.1:6152
    export all_proxy=socks5://127.0.0.1:6153
}

function proxyoff {
    unset https_proxy
    unset http_proxy
    unset all_proxy
}
function grepport {
    netstat -vanp tcp | grep $1
}
