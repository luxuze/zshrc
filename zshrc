                                                                                                        # If you come from bash you might have to change your $PATH.
ZSH_THEME="random" # (...please let it be pie... please be some pie..)

plugins=(
	z
	kubectl
	git
	sudo
	vi-mode
)
source <(kubectl completion zsh)

# --------------------------------------------------------git alias
function quickpush () {
    git add -A
    git commit -m "$1"
    git pull --rebase
    git push
}
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# --------------------------------------------------------git alias

alias aliyun='ssh root@luxuze.cn'

export PATH=$PATH:/usr/local/go/bin
export GOPROXY=https://goproxy.cn

function proxyon {
    export https_proxy=http://192.168.31.230:7890
    export http_proxy=http://192.168.31.230:7890
    export all_proxy=socks5://192.168.31.230:7891
}

function proxyoff {
    unset https_proxy
    unset http_proxy
    unset all_proxy
}

# Mac
function grepport {
    netstat -vanp tcp | grep $1
}
