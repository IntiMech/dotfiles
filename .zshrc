# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set environment variables for CUDA
export CUDA_HOME="/opt/cuda"
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
 
# Set environment variables
export P10K_PINK='#f5c2e7'
export ANDROID_HOME="$HOME/Android/Sdk"
export JAVA_HOME="/opt/openlogic-openjdk-8u382-b05-linux-x64"
export ZSH="$HOME/.oh-my-zsh"

# Update PATH variable
# Includes user's bin directory, local bin, Ruby, Glow, Android SDK tools, Java, and Deno
export PATH="$HOME/bin:/usr/local/bin:$PATH"              # Standard user and local binaries
export PATH="$PATH:/usr/bin/ruby"                         # Ruby
export PATH="$PATH:/usr/bin/glow"                         # Glow
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools" # Android SDK
export PATH="$JAVA_HOME/bin:$PATH"                        # Java
export PATH="$PATH:$HOME/.deno/bin"                       # Deno



ZSH_THEME="powerlevel10k/powerlevel10k"



# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"


# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

PROMPT="$PROMPT\$(vi_mode_prompt_info)"
RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"

# defaults
VI_MODE_CURSOR_NORMAL=2
VI_MODE_CURSOR_VISUAL=6
VI_MODE_CURSOR_INSERT=6
VI_MODE_CURSOR_OPPEND=0





# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
