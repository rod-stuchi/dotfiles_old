# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH="$PATH:/opt/yarn/bin"
export ANDROID_HOME=/disks/1TB/android/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
export MANPAGER="nvim -c 'set ft=man' -"
export EDITOR=nvim

# If you don't want to exclude hidden files, use the following command:
export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.config/ag/agignore -g ""'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--bind 'ctrl-a:select-all+accept'"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(adb archlinux colorize dirhistory docker dotenv encode64 frontend-search git git-extras git-open history jsontools jump mix pip react-native sudo yarn z)

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
alias setclip="xclip -selection clipboard"
alias getclip="xclip -selection clipboard -o"
alias cd..="cd .."
alias config="/usr/bin/git --git-dir=/disks/1TB/Git/rods_config.git --work-tree=$HOME"
alias gitroot="/usr/bin/git --git-dir=/home/rods/.gitroot --work-tree=/"
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
alias rodsDisableWebCam='sudo modprobe -r uvcvideo'
alias rodsEnableWebCam='sudo modprobe -a uvcvideo'

alias rodsmpd='mpd -v .config/mpd/mpd.conf'

# functions

bin2dec(){ echo "$((2#$1))" }

copy(){ echo -n "$1" | xclip -selection clipboard }

rodsTrueColor() {
  # https://gist.github.com/XVilka/8346728
  curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash
}

rodsListWifi() {
  iwlist wlp3s0 scan | ag "ESSID|Encryp|Quality" | xargs -L2 | sort -rk 1
}

rodsPacRequiredBy() {
  pacman -Qi "$1" | awk -F'[:<=>]' '/^Required/ {print $2}' | xargs -n1 | sort -u
}

rodsPacDependsOn() {
  pacman -Si "$1" | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u
}

rodsCopyFromTo () {
  rsync -ai --chmod u=rw,go=r "$1" "$2" | pv -ls $(find "$1" -type f | wc -l) > /dev/null
}

rodsPipUpgrade () {
  sudo pip list --outdated --format=freeze | cut -d = -f 1 | xargs -n1 sudo pip install -U
}

rodsPipOutdated () {
  sudo pip list --outdated --format=columns
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
  WEATHER_URL="http://api.openweathermap.org/data/2.5/find?q=liberdade,br&APPID=3fa9fa72d3d8db1a0bf6b9383239faa7&units=metric"
  wget -qO- "${WEATHER_URL}" | python -m json.tool
}

rodsFTP () {
  echo ftp://192.168.2.129:21
  echo user: rods
  echo pass: 123
  sudo python -m pyftpdlib -w -p 21 -i 192.168.2.129 -u rods -P 123
}

# fv - open file in neovim
fv() {
  rg --files | fzf --bind 'enter:execute(nvim {1} < /dev/tty)'
}

# fgd - git diff not in stage
fgd() {
  git ls-files -m |
  fzf --ansi --sort --reverse --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (xargs -I % sh -c 'git diff %') << 'FZF-EOF'
                {}
FZF-EOF"
}


# fgd - git diff HEAD~X..HEAD~Y
fgdh() {
  git diff --name-only HEAD~$1..HEAD~$2 |
  fzf --ansi --sort --reverse --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (xargs -I % sh -c 'git diff HEAD~$1..HEAD~$2 %') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fgd - git diff cached (in stage)
fgdc() {
  git --no-pager diff --cached --name-only |
  fzf --ansi --sort --reverse --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (xargs -I % sh -c 'git diff --cached %') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux --reverse -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux --reverse -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# gbar - list 'git branch' by author, ordered by last commit date
gbar() {
  for branch in `git branch -r | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
}

# get total usage memory em MB by process name, like chrome, vim, etc
memusage() {
  t=0;
  pids=$(pidof $1);
  for p in ${(ps: :)pids}; do
    cat /proc/$p/status \
      | grep -i vmrss \
      | awk '{print $2}';
  done \
    | while read m; do let t=$t+$m; echo $(($t/1024)); done \
    | tail -n1 \
    | xargs -I@ echo $1":" @ "MB"
}

# grabbed from https://gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}
# https://unix.stackexchange.com/questions/106375/make-zsh-alt-f-behave-like-emacs-alt-f
bindkey '\ef' emacs-forward-word
bindkey '\eb' emacs-backward-word

# commands apropos / search by commands
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

