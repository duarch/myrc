########################################
# HISTÓRICO
########################################
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# não duplica comandos no histórico
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

# compartilha histórico entre sessões
setopt SHARE_HISTORY

########################################
# AUTOCOMPLETE & SUGESTÕES
########################################
autoload -U +X compinit
compinit

# sugestões de correção de typos
setopt CORRECT

# menu de autocompletar com navegação
zstyle ':completion:*' menu select

########################################
# NVM (Node Version Manager)
########################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

########################################
# ANGULAR CLI AUTOCOMPLETE
########################################
source <(ng completion script)

########################################
# OH MY POSH (tema unicorn)
########################################

if command -v oh-my-posh >/dev/null 2>&1; then
  OMP_CONFIG="$HOME/dev/myrc/oh-my-posh-duarch.json"

  if [ -f "$OMP_CONFIG" ]; then
    eval "$(oh-my-posh init zsh --config "$OMP_CONFIG")"
    fi
fi



########################################
# ALIASES ÚTEIS
########################################
alias ll='ls -lah'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

alias python=python3
