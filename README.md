# Config

this is my personal config for macOS and Linux systems. I use it to set up a new system quickly and to keep my dotfiles in sync between my machines.

## Installation

create a <b>.zshrc</b> file in your home directory if it doesn't exist

```shell
touch ~/.zshrc
```

Here we define the <b>CONFIG</b> variable to point to the <b>~/.config</b> directory

```shell
echo "CONFIG = $HOME/.config\nsource $CONFIG/zshrc.sh" >> ~/.zshrc
```

Clone the repository to the <b>~/.config</b> directory

```bash
git clone https://github.com/kaiorferraz/.config ~/.config
```

Update the shell to use <b>zsh</b>

```bash
chsh -s $(which zsh)
```

Restart the terminal and you're good to go!

## Usufull commands

### Install brew

install brew on the <b>~/.config</b> directory. if you run "install brew" it will install brew on the <b>/usr/local</b> directory for intel macs and <b>/opt/homebrew</b> for m1 macs

```bash
install brew local
```

### Install brew packages

```bash
install package-name
```

### Remove package

```bash
remove package-name
```

### generate random password

It will generate a random password with 26 characters and copy it to the clipboard

```bash
rand pass
```

### get all the hash of the plist files

This command will create a file called <b>plist_shasum.txt</b> with all the hash of the plist files within LaunchAgents and LaunchDaemons directories and save it to the <b>~/.config</b> directory. later you can run "plist verify" to verify if the plist files were changed

```bash
plist get
```
