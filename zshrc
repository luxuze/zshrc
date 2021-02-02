# o-m-zsh >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
#
export ZSH="/root/.oh-my-zsh"

ZSH_THEME="muse"

plugins=(
	z
# 	kubectl
	git
	sudo
# 	vi-mode
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
function proxyon {
	export https_proxy=http://172.17.16.1:7890
	export http_proxy=http://172.17.16.1:7890
	export all_proxy=socks5://172.17.16.1:7891
}

function proxyoff {
    unset https_proxy
    unset http_proxy
    unset all_proxy
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
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
#
# path <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
