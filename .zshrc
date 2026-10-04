# Created by newuser for 5.9
# -------- HISTORY --------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory sharehistory hist_ignore_dups hist_ignore_space

# -------- KEYBINDINGS --------
bindkey -v  # or -v

# -------- COMPLETION --------
autoload -Uz compinit && compinit

# -------- PLUGINS --------
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -------- TOOLS --------
eval "$(zoxide init zsh)"

# -------- FZF --------
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh
[ -f /usr/share/fzf/shell/completion.zsh ] && source /usr/share/fzf/shell/completion.zsh

# Use find instead of fd
export FZF_DEFAULT_COMMAND='find . -type f 2>/dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS="
--height 40%
--layout=reverse
--border
--preview 'bat --style=numbers --color=always {} 2>/dev/null'
"
export PATH=$PATH:/usr/local/go/bin

# -------- BETTER DEFAULTS --------
alias ls='eza --icons=auto'
alias ll='eza -lah --icons=auto'
alias la='eza -a --icons=auto'
alias l.='eza -d .* --icons=auto'
alias cat='bat'
alias grep='rg'
alias cd='z'
alias vi="nvim"
alias docker="sudo docker"

# -------- POWERFUL FIND ALIASES --------

# Files only (clean)
alias ffiles='find . -type f 2>/dev/null'

# Directories only
alias fdirs='find . -type d 2>/dev/null'

# Ignore common junk
alias fclean='find . -type f \
  -not -path "*/.git/*" \
  -not -path "*/node_modules/*" \
  -not -path "*/.cache/*" \
  2>/dev/null'

# Search by name
fname() {
  find . -type f -iname "*$1*" 2>/dev/null
}

# -------- FZF + FIND SUPER COMBOS --------

# Fuzzy find file
alias ff='fclean | fzf'

# Fuzzy find dir and cd
fcd() {
  cd "$(fdirs | fzf)"
}

# Open file with preview
fbat() {
  find . -type f 2>/dev/null | \
  fzf --preview "bat --color=always {}"
}

# Search content + jump to file
frg() {
  rg --line-number --no-heading "$1" | \
  fzf | cut -d: -f1 | xargs -r nvim
}

# Edit file quickly
fe() {
  nvim "$(fclean | fzf)"
}

# -------- ADVANCED (VERY POWERFUL) --------

# Find large files
flarge() {
  find . -type f -size +100M 2>/dev/null
}

# Find recently modified
frecent() {
  find . -type f -mtime -1 2>/dev/null
}

# Find by extension
fext() {
  find . -type f -name "*.$1" 2>/dev/null
}

# Kill process via fzf
fkill() {
  ps aux | fzf | awk '{print $2}' | xargs kill -9
}

# Copy stdin or a file to clipboard
copy() {
  if [[ -t 0 ]]; then
    # No stdin → treat argument as file
    if [[ -f "$1" ]]; then
      if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        wl-copy < "$1"
      else
        xclip -selection clipboard < "$1"
      fi
    else
      echo "File not found: $1"
      return 1
    fi
  else
    # Piped input
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
      wl-copy
    else
      xclip -selection clipboard
    fi
  fi
}

# Paste clipboard to stdout
paste() {
  if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    wl-paste
  else
    xclip -selection clipboard -o
  fi
}

# Copy absolute file path
copypath() {
  if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    realpath "$1" | wl-copy
  else
    realpath "$1" | xclip -selection clipboard
  fi
}

ccmd() {
  local output

  output="$("$@" 2>&1)"

  if [[ -n "$WAYLAND_DISPLAY" ]]; then
    printf '$ %s\n%s\n' "$*" "$output" | wl-copy
  else
    printf '$ %s\n%s\n' "$*" "$output" | xclip -selection clipboard
  fi
}

# -------- CLEAN --------
alias c='clear'

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

. "$HOME/.local/bin/env"
