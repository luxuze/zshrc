# o-m-zsh >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
#
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=ys

plugins=(
	z
 	kubectl
	git
	sudo
	zsh-autosuggestions
	zsh-syntax-highlighting
	# rand-quote
)

HIST_STAMPS=yyyy-mm-dd

source $ZSH/oh-my-zsh.sh
#source <(kubectl completion zsh)

bindkey ',' autosuggest-accept

# path >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_INSTALL_FROM_API=1
export JAVA_HOME_17="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
export JAVA_HOME_21="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export JAVA_HOME_23="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

export JAVA_HOME=$JAVA_HOME_21
export PATH="$JAVA_HOME/bin:$PATH"

export APP_ENV=dev

#
# path <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

function x.code_count {
	git log --format='%aN' | sort -u | while read name; do
    stats=$(git log --author="$name" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s", add, subs, loc }' -)
    total_lines=$(echo "$stats" | awk -F': ' '{print $4}')
    if [ "$total_lines" -ne 0 ]; then
        echo -e "$name\t$stats"
    fi
done | sort -k4 -nr -t:
}

if command -v cmd &> /dev/null; then
	cmd ascii-art --name="HELLO WORLD" --face=slant
fi

function set.go.proxy.cn {
	export GOPROXY="https://goproxy.cn,direct"
}

function set.go.proxy.official {
	# GOPROXY=="https://proxy.golang.org,direct"
	unset GOPROXY
}

function x.awake {
	caffeinate -d -t 9999999999999999
}

function x.quickpush {
	git add . && \
	git commit -m "$(date '+%Y-%m-%d %H:%M:%S')" && \
	git pull --rebase && \
	git push
}

function x.grepport {
	if [ $# -gt 0 ]; then
		lsof -i :$1 | grep LISTEN
	else
		lsof -iTCP -sTCP:LISTEN -n -P | grep LISTEN
	fi
}

function x.du {
	local target_dir="${1:-.}"
	du -sh "$target_dir"/* | sort -rh
}
