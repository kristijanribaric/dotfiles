#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


eval "$(starship init bash)"
export PATH="$HOME/.local/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DOTNET_ROOT=$HOME/.dotnet
#export PATH="$HOME/.dotnet:$HOME/.dotnet/tools:$PATH"
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

alias paru='chrt --idle 0 ionice -c 3 paru'

export EDITOR=nvim

# pnpm
export PNPM_HOME="/home/kristijan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
source "$HOME/.cargo/env"

alias pn=pnpm
alias ff=fastfetch
