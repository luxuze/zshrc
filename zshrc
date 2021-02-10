# o-m-zsh >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
#
export ZSH="/root/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(
	z
 	kubectl
	git
	sudo
 	vi-mode
	zsh-autosuggestions
	zsh-syntax-highlighting
)

HIST_STAMPS="yyyy-mm-dd"

source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)

bindkey ',' autosuggest-accept
#
# o-m-zsh <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


# proxy >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# terminal surge enable
function surge.proxy.on {
	export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153
}
# terminal surge disable
function surge.proxy.off {
    unset https_proxy
    unset http_proxy
    unset all_proxy
}

# 七牛Go代理
function set.go.proxy.out {
     export GOPROXY=https://goproxy.cn
 }
# 公司Go代理
function set.go.proxy.in {
     export GOPROXY=http://goproxy.bilibili.co
     export GOSUMDB=off
}
#
# proxy <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


# alias >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
alias aliyun='ssh root@luxuze.cn'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# Mac
function grepport {
    netstat -vanp tcp | grep $1
}
#
# alias <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


# path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/root/go/bin
export GOPATH=~/go
export GO111MODULE=on
#
# path <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

set.go.proxy.out
