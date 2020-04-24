# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(extract git sudo vi-mode brew)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/opt/libxml2/bin:$HOME/.rbenv/bin:/opt/local/bin:/opt/local/sbin:/Users/chiua01/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:$PATH"
export MANPATH="/opt/local/share/man:/usr/share/man:/usr/local/man:$MANPATH"
export INFOPATH="/usr/local/man:$INFOPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='gvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Alt-s inserts sudo at beginning of line (sudo plugin---esc-esc doesn't work 
# in vi-mode.)
bindkey "^[s" sudo-command-line

# Reuse instance of gvim.
alias g='gvim --remote-silent'

# Run things in the background.
background() {
  "$@" &
}

# Suffix aliases.
alias -s tex=vim

# Global aliases.
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias pip=pip3

# Extended globbing.
setopt extendedglob

# History completion.
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

source /Users/chiua01/zaw/zaw.zsh

eval "$(rbenv init -)"

# Edit my 'did' file. https://theptrk.com/2018/07/11/did-txt-file/
alias did="vim +'normal Go' +'r!date' ~/did.txt"

# export PATH="$HOME/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/chiua01/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/chiua01/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/chiua01/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/chiua01/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

