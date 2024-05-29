
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set environment variables for CUDA
export CUDA_HOME="/opt/cuda"
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:/usr/lib:$LD_LIBRARY_PATH"
export PATH="$PATH:/home/mrmagee/LmStudio/squashfs-root/resources/app/.webpack"

# Set environment variables
export P10K_PINK='#f5c2e7'
export ANDROID_HOME="$HOME/Android/Sdk"
export JAVA_HOME="/usr/lib/jvm/java-22-openjdk"
export ZSH="$HOME/.oh-my-zsh"
export XDG_DATA_DIRS="/usr/local/share:/usr/share:/home/mrmagee/.local/share"

# Update PATH variable
export PATH="$HOME/bin:/usr/local/bin:$PATH"              # Standard user and local binaries
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools" # Android SDK
export PATH="$JAVA_HOME/bin:$PATH"                        # Java
export PATH="$ANDROID_HOME/build-tools/34.0.0:$PATH"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -v  # Enable vi keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Prompt configuration
PROMPT="$PROMPT\$(vi_mode_prompt_info)"
RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"

# Vi mode cursor settings
VI_MODE_CURSOR_NORMAL=2
VI_MODE_CURSOR_VISUAL=6
VI_MODE_CURSOR_INSERT=6
VI_MODE_CURSOR_OPPEND=0

# >>> conda initialize >>>
__conda_setup="$('/home/mrmagee/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mrmagee/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mrmagee/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mrmagee/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Source fzf and zoxide
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

# Start ssh-agent and add keys without producing output during shell initialization
SSH_AGENT_FILE="$HOME/.ssh-agent-thing"
if [ ! -S "$SSH_AUTH_SOCK" ]; then
  if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -s > "$SSH_AGENT_FILE"
  fi
  if [ -f "$SSH_AGENT_FILE" ]; then
    eval "$(cat "$SSH_AGENT_FILE")" >/dev/null 2>&1
  fi
fi
# ssh-add -q ~/.ssh/id_ed25519 2>/dev/null

export EDITOR='nvim'

# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/home/mrmagee/.cache/lm-studio/bin"
alias tmux="tmux -f ~/.config/tmux/tmux.conf"
