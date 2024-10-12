BATDIFF_USE_DELTA=true 
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=on
typeset -g POWERLEVEL9K_CONFIG_FILE=~/.p10k.zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

export ZSH="$HOME/.oh-my-zsh"

COMPLETION_WAITING_DOTS="true"

# ------- omz plugins --------
plugins=(git
  aliases
  example
  emoji
  man
  tldr
  fzf
  zoxide
  fzf
  sudo
  archlinux
  vi-mode
  git
  tmux
  history
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
)


source $ZSH/oh-my-zsh.sh
source Hyde.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh

# -------------------  Environment Variables -------------------
export YSU_MESSAGE_POSITION="after"
export ZOXIDE_CMD_OVERRIDE="cd"
export EDITOR=nvim
export BROWSER=firefox
export FZF_DEFAULT_OPTS="--inline-info --bind 'ctrl-/:change-preview-window(hidden|)'  --wrap --wrap-sign='↳ ' "
export PATH=$HOME/.local/bin:$PATH
export SHELL=/usr/bin/zsh

source ~/catppuccin_mocha-zsh-syntax-highlighting.zsh
source ~/scripts/colorize.sh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(register-python-argcomplete pipx)"
source /usr/share/wikiman/widgets/widget.zsh
# export PATH="$PATH:$(yarn global bin)"

# --------- aliases -----------

alias nmadib='nmcli d wifi connect "Arman Tahsin Adib 2"'
alias nmredmi='nmcli d wifi connect "Redmi 12"'
alias y="yazi"
alias lg="lazygit"
alias opz="v ~/.zshrc"
alias c="clear"
# alias cd="z"
alias ls="eza --icons=always --color=always"
alias l="eza -a -1 --icons=always --color=always --long"
alias ll="eza -1 --icons=always --color=always --long"
alias ld="eza -D -a --color=always --icons=always"
alias lt="eza --tree -a --icons=always --color=always --no-git"
alias open="xdg-open"

# ---------- neovim aliases ----------------
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kick nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias v="nvim"
alias n="NVIM_APPNAME=adib nvim"
alias emulator="~/Android/Sdk/emulator/emulator"



# ----------- Dracula Man-page theme ------------------------
export MANPAGER="/usr/bin/less -s -M +Gg"
export LESS_TERMCAP_mb=$'\e[1;31m'      # begin bold
export LESS_TERMCAP_md=$'\e[1;34m'      # begin blink
export LESS_TERMCAP_so=$'\e[01;45;37m'  # begin reverse video
export LESS_TERMCAP_us=$'\e[01;36m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'         # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'         # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'         # reset underline
export GROFF_NO_SGR=1                   # for konsole


# ----- NVM -----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# ------------ ZSH-command-not-found -----------
function command_not_found_handler {
  local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
  printf 'zsh: command not found: %s\n' "$1"
  local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
  if (( ${#entries[@]} )) ; then
    printf "${bright}$1${reset} may be found in the following packages:\n"
    local pkg
    for entry in "${entries[@]}" ; do
      local fields=( ${(0)entry} )
      if [[ "$pkg" != "${fields[2]}" ]] ; then
        printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
      fi
      printf '    /%s\n' "${fields[4]}"
      pkg="${fields[2]}"
    done
  fi
  return 127
}

# ------------------ Browsing tldr ------------------------
ts () {
  # If no query is passed, use an empty string
  local query="${1:-}"

  # Use fzf with the specified query or an empty string
  local choice=$(tldr --list | sed 's/ (en)//g' | sort | uniq | fzf --preview="tldr {}" --reverse --query="$query" --preview-window=80% --preview-label='[ preview-window ]' --cycle --bind 'ctrl-/:change-preview-window(hidden|)' --wrap --wrap-sign='↳ ' --preview-window=border-bold --info=inline --border bold)

  if [[ -z $choice ]]; then
    echo "Nothing Selected"
    return 0
  fi

  tldr --color "$choice"
}

# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path ~/.zsh/cache

# setopt CORRECT_ALL
# setopt HIST_IGNORE_SPACE    # Ignore commands that start with a space
# setopt HIST_IGNORE_DUPS     # Ignore duplicate commands in history
# setopt HIST_FIND_NO_DUPS    # Don't suggest duplicate history entries
# setopt HIST_NO_FUNCTIONS    # Don't store function definitions in history
# setopt HIST_NO_STORE        # Don't store commands that fail (i.e., return non-zero status)


# ------------------ fzf config --------------------------------------------
export FZF_CTRL_T_OPTS="--preview '~/fzf-preview.sh {}' --bind 'ctrl-/:change-preview-window(hidden|)' --wrap --wrap-sign='↳ ' --height=60% --ansi"
export FZF_ALT_C_OPTS="--preview 'eza -G --color=always {}' --border sharp --bind 'ctrl-/:change-preview-window(hidden|)' --wrap --wrap-sign='↳ ' --height=50% --preview-window down,20%,border-sharp"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "eza --tree --icons --color=always -a {} | head -200 " "$@" ;;
    export|unset) fzf --preview "eval 'echo \$' {}"     "$@" ;;
    ssh)          fzf --preview "dig {}"    "$@" ;;
    unalias)      fzf --preview "alias {}"   "$@"  ;;
    *)            fzf --preview "~/fzf-preview.sh {}"  "$@" ;;
  esac
}

source ~/fzf-git.sh

# -- FZF
export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d  --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_comprun_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

function update() {
  connection=$(nmcli networking connectivity)
  if [[ "$connection" == "none" ]];then
    echo "Check your Internet Connection"
    return 127
  else
    paru
    hyprctl reload
    sudo updatedb
    sudo mandb
    sudo mandb -c
    tldr -u
  fi
}

alias so="exec zsh"

bindkey -s '^[r' "so\n"
bindkey -s '^B' "btop\n"

# autoload -U +X bashcompinit && bashcompinit
# source /usr/share/bash-completion/completions/yay

autoload -U compinit
compinit

inspac ()
{
  paru -Slq | fzf --multi --preview 'paru -Si {1}' --height=~50% --preview-window=70%| xargs -ro paru -S
}

delpac()
{
  paru -Qq | fzf --multi --preview 'paru -Qi {1}' --height 50%| xargs -ro paru -Rns
}



ZSH_THEME="robbyrussell"

alias fetch='neofetch --config ~/neofetch-themes/small/simplefetch.conf'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

alias fetch="neofetch --config ~/neofetch-themes/small/simplefetch.conf"

echo -e "\033[32m$(fortune)\033[0m"



export PATH="$HOME/.local/bin:$PATH"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools


export AUTO_NOTIFY_IGNORE=("nvim" "xdg-open" "yazi" "code" "vim" "firefox" "btop" "cava" "pipes.sh" "tty-clock" "asciiquarium" "zed" "idea" "python" "man" "less" "zsh" "bash" "fish")
