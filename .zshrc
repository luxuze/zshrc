export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=ys
plugins=(
  extract
  history
  z
  kubectl
  git
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
)
HIST_STAMPS=yyyy-mm-dd
source $ZSH/oh-my-zsh.sh
bindkey ',' autosuggest-accept


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

function x.code_count {
  git log --pretty=format:'%aN' --numstat | \
  awk '
    BEGIN {
      print "Author\tAdded Lines\tRemoved Lines\tTotal Lines"
    }
    $1 ~ /^[0-9-]+$/ {
      added[prev_author] += $1
      removed[prev_author] += $2
      total[prev_author] += $1 - $2
      next
    }
    {
      prev_author = $0
    }
    END {
      n = 0
      for (author in total) {
        authors[++n] = author
      }
      for (i = 1; i <= n; i++) {
        for (j = i + 1; j <= n; j++) {
          if (total[authors[j]] > total[authors[i]]) {
            temp = authors[i]
            authors[i] = authors[j]
            authors[j] = temp
          }
        }
      }
      for (i = 1; i <= n; i++) {
        author = authors[i]
        if (total[author] != 0) {
          printf "%s\t%d\t%d\t%d\n",
            author, added[author], removed[author], total[author]
        }
      }
    }
  ' | column -t -s $'\t'
}


if command -v cmd &> /dev/null; then
  cmd ascii-art --name="HELLO WORLD" --face=slant
fi


function init.oh_my_zsh.plugins {
  local zsh_custom="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"
  local syntax_plugin="$zsh_custom/plugins/zsh-syntax-highlighting"
  local auto_suggest_plugin="$zsh_custom/plugins/zsh-autosuggestions"

  echo "🔍 Checking Oh My Zsh plugins..."

  if [ ! -d "$syntax_plugin" ]; then
    echo "📦 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_plugin"
    echo "✓ zsh-syntax-highlighting installed"
  else
    echo "✓ zsh-syntax-highlighting already installed"
  fi

  if [ ! -d "$auto_suggest_plugin" ]; then
    echo "📦 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$auto_suggest_plugin"
    echo "✓ zsh-autosuggestions installed"
  else
    echo "✓ zsh-autosuggestions already installed"
  fi

  echo "✓ All Oh My Zsh plugins are ready!"
  echo "💡 Tip: Reload shell with 'exec zsh' to apply changes"
}


function set.go.proxy.cn {
  export GOPROXY="https://goproxy.cn,direct"
}

function set.go.proxy.official {
  unset GOPROXY
}


function init.brew.mirror {
  if [ $# -ne 1 ]; then
    echo "Usage: init.brew.mirror <mirror>"
    echo "Available mirrors: ustc, tsinghua"
    return 1
  fi

  local mirror=$1
  local brew_repo brew_core brew_cask bottles_domain

  case "$mirror" in
    ustc)
      brew_repo="https://mirrors.ustc.edu.cn/brew.git"
      brew_core="https://mirrors.ustc.edu.cn/homebrew-core.git"
      brew_cask="https://mirrors.ustc.edu.cn/homebrew-cask.git"
      bottles_domain="https://mirrors.ustc.edu.cn/homebrew-bottles"
      ;;
    tsinghua)
      brew_repo="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
      brew_core="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
      brew_cask="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-cask.git"
      bottles_domain="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
      ;;
    *)
      echo "Error: Unknown mirror '$mirror'"
      echo "Available mirrors: ustc, tsinghua"
      return 1
      ;;
  esac

  echo "🔄 Switching Homebrew mirror to: $mirror"

  if ! command -v brew &> /dev/null; then
    echo "⚠️  Homebrew not found. Skipping git remote updates."
  else
    if [ -d "$(brew --repo)" ]; then
      echo "  • Updating Homebrew repo..."
      git -C "$(brew --repo)" remote set-url origin "$brew_repo" 2>/dev/null
    fi

    if [ -d "$(brew --repo homebrew/core)" ]; then
      echo "  • Updating Homebrew Core..."
      git -C "$(brew --repo homebrew/core)" remote set-url origin "$brew_core" 2>/dev/null
    fi

    if [ -d "$(brew --repo homebrew/cask)" ]; then
      echo "  • Updating Homebrew Cask..."
      git -C "$(brew --repo homebrew/cask)" remote set-url origin "$brew_cask" 2>/dev/null
    fi
  fi

  echo "  • Updating environment variables in ~/.zshrc..."

  local zshrc_file="$HOME/.zshrc"
  local temp_file="${zshrc_file}.tmp"

  grep -v "^export HOMEBREW_BOTTLE_DOMAIN=" "$zshrc_file" | \
  grep -v "^export HOMEBREW_BREW_GIT_REMOTE=" | \
  grep -v "^export HOMEBREW_CORE_GIT_REMOTE=" | \
  grep -v "^export HOMEBREW_CASK_GIT_REMOTE=" > "$temp_file"

  cat >> "$temp_file" << EOF

export HOMEBREW_BOTTLE_DOMAIN="$bottles_domain"
export HOMEBREW_BREW_GIT_REMOTE="$brew_repo"
export HOMEBREW_CORE_GIT_REMOTE="$brew_core"
export HOMEBREW_CASK_GIT_REMOTE="$brew_cask"
export HOMEBREW_INSTALL_FROM_API=1
EOF

  mv "$temp_file" "$zshrc_file"

  echo "  • Reloading shell configuration..."
  source "$zshrc_file"

  echo "✓ Homebrew mirror switched to: $mirror"
}


function x.awake {
  caffeinate -d -t 99999999999999
}


function x.push {
  git add . && \
  git commit --no-verify -m "$(date '+%Y-%m-%d %H:%M:%S')" && \
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

function x.delay {
  local time_spec=$1
  [[ $# -lt 1 ]] && { echo "Usage: x.delay <time>  (e.g., 2h, 30m, 5s)"; return 1; }

  local number="${time_spec%[smhd]}"
  local unit="${time_spec: -1:1}"
  [[ "$unit" =~ ^[smhd]$ ]] || unit="s"
  [[ "$number" =~ ^[0-9]+$ ]] || { echo "Error: Invalid format '$time_spec'"; return 1; }

  local seconds=$number
  [[ "$unit" == "m" ]] && seconds=$((number * 60))
  [[ "$unit" == "h" ]] && seconds=$((number * 3600))
  [[ "$unit" == "d" ]] && seconds=$((number * 86400))

  sleep "$seconds"
}
