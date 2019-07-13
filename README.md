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

## Usefull blended commands

#### Add permission to ImageMagic to generate thumbnails from PDF files

```console
sudo sed -ie 's/rights="none"/rights="all"/' /etc/ImageMagick-7/policy.xml
convert -thumbnail x300 -background white -alpha remove "{file}.pdf[0]" "{file}_thumb.png"
```

#### Remove files not in use, when it can not find any reference

```console
ls PATH | xargs -L1 -I{} sh -c 'rg -q {} *.md; if [[ $? != 0 ]]; then rm PATH/{}; fi'
```

#### Compress with XZ (better compression level) with progress

```console
tar cpf - _*.json | pv -pbrt -s $(du -shc *.json | cut -f1 | tail -n1) | xz -9 > archive.tar.xz
```

#### Add find|fd files to Tar

```console
fd {name} -t f -print0 | tar -czvf {file}.tar.gz --null -T -
```

#### To list content of file

```console
tar tvf archive.tar.xz
```

#### To see the compress rate

```console
xz -l archive.tar.xz
```

#### To create a file with size

[+info](https://unix.stackexchange.com/a/33634)

```console
head -c 15M </dev/urandom >myfile
```

#### MySQL convert_tz returns null

[+info](https://stackoverflow.com/a/14454465)

```console
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -uroot mysql
```

#### Find a string in all git branches
[+info](https://stackoverflow.com/q/7151311)

```console
# by branch name
git show-ref --heads | sort -u | awk '{ print $2 }' | xargs git grep "string"

# by sha1sum branch
git show-ref -s | sort -u | xargs git grep "string"

# by commits
git rev-list --all | xargs git grep "string"
```

# Troubleshooting

### after suspend headphone doesn't reconnect (need replug)

How to solve

    git clone https://github.com/Unrud/init-headphone

```console
./autogen.sh
./configure
make
make install

systemctl enable init-headphone
```
