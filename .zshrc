# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH="$PATH:/opt/yarn/bin"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
export MANPAGER="nvim -c 'set ft=man' -"
export EDITOR=nvim

# If you don't want to exclude hidden files, use the following command:
export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.config/ag/agignore -g ""'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(adb archlinux colorize dirhistory docker dotenv encode64 frontend-search git git-extras history jsontools jump mix pip react-native sudo yarn z) 

source $ZSH/oh-my-zsh.sh
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

if [[ $TERM =~ konsole.* ]]; then
    export FZF_DEFAULT_OPTS='--color fg+:5,hl+:6'
fi

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7

  BASE16_SHELL=$HOME/.config/base16-shell/
  [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

 export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias vim="nvim"
alias ld="ls -d */"
alias lld="ls -ld */"
alias cd..="cd .."
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias rodsdisk="df -h -l -t ext4 -t fuseblk"
alias rodsvideo-720p="youtube-dl -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' -o '%(title)s.%(ext)s' "
alias rodsMemo='function _memo(){smem -t -k -c pss -P "$1" | tail -n 1}; _memo'
alias rodsFindDup="find . -type f -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate"
alias rodsCpMonth='~/.scripts/comprovantes/month'
alias rodsCpAll='~/.scripts/comprovantes/all'
alias rodsNetFatura='~/.scripts/net/fatura'
alias rodsComGasDec='~/.scripts/comgas/decrypt'
alias rodsComGasFatura='~/.scripts/comgas/fatura'
alias rodsSubmarinoDec='~/.scripts/submarino/decrypt'
alias rodsSubmarinoFatura='~/.scripts/submarino/fatura'
alias rodsAmexFatura='~/.scripts/amex/fatura'
alias rodsNubankFatura='~/.scripts/nubank/fatura'
alias rodsmpd='mpd -v .config/mpd/mpd.conf'

# functions

bin2dec(){ echo "$((2#$1))" }

copy(){ echo -n "$1" | xclip -selection clipboard }

rodsPacRequiredBy() {
  pacman -Qi "$1" | awk -F'[:<=>]' '/^Required/ {print $2}' | xargs -n1 | sort -u
}

rodsPacDependsOn() {
  pacman -Si "$1" | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u
}

rodsCopyFromTo () {
  rsync -ai --chmod u=rw,go=r "$1" "$2" | pv -ls $(find "$1" -type f | wc -l) > /dev/null
}

rodsColor () {
  #find ~/.config/i3/base16/ -perm -u+x | xargs -L 1 basename | fzf --bind 'enter:execute(~/.config/i3/base16/{})+abort'
  find ~/.config/i3/base16/ -perm -u+x | xargs -L 1 basename \
    | fzf \
    | xargs -i sh -c '~/.config/i3/base16/{} && ~/.config/termite/base16/{} && sed -i -e "s/colorscheme base16-.*/colorscheme base16-{}/" ~/.config/nvim/init.vim'

  echo "~/.config/i3/config ::"
  cat ~/.config/i3/config | head -n 22 | sed -e 's/^/          /g'
  echo "~/.config/termite/config ::"
  cat ~/.config/termite/config | head -n 30 | sed -e 's/^/          /g'
  echo "~/.config/nvim/init.vim ::"
  cat ~/.config/nvim/init.vim | tail -n +153 | head -8 | sed -e 's/^/          /g'
}

weather () {
  WEATHER_URL="http://api.openweathermap.org/data/2.5/find?q=jabaquara&APPID=3fa9fa72d3d8db1a0bf6b9383239faa7&units=metric"
  wget -qO- "${WEATHER_URL}" | python -m json.tool
}

# commands apropos / search by commands
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

