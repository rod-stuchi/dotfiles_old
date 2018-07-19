# dotfiles
My Arch dotfiles

### clone dotfiles
```console
git clone https://github.com/rod-stuchi/dotfiles.git .dotfiles --bare --no-checkout
```

### install deps
```sh
# asdf-vm
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# On archlinux
sudo pacman -S fzf moreutils

# On macOS
brew install fzf moreutils
```

## checkout configuration
```console
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME add .zshrc
/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout -p master .zshrc

ggit add .config/nvim
ggit checkout -p {master|macos} .config/nvim
```
Or 
```console
ggit checkout {master|macos} .config/nvim
```

### ignore untracked files
```console
ggit config --local status.showUntrackedFiles no
```
