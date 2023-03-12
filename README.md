# Vaernil's dotfiles of super fun and adventure
coming back to this after few years hiatus, time to finally organize it
ADHD lifestyle :)

## Inspiration
* [r/unixporn](https://www.reddit.com/r/unixporn/)
* [@z3bra](http://blog.z3bra.org/)
* [@neeasade](https://github.com/neeasade/dotfiles)
* [@noctuid](https://github.com/noctuid/dotfiles)
* [@windelicato](https://github.com/windelicato/dotfiles)
* [@SeraphyBR](https://github.com/SeraphyBR/DotFiles)
* [@durdn](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
	
## PC
### Screenshot

## Install on new machines - not tested
## Requirements
I will try to make all the commands POSIX compliant, you can use the export function, but all my homies hate bash

## SETUP

### ENV
Temporarily set shell environment variables if the system doesn't do it for you.
``` sh
gituser='Vaernil'
gitmail='vaernil@gmail.com'
```
	
#### Git
Setup your github account
``` sh
git config --global user.name  "${gituser}"
git config --global user.email "${gitmail}"
```
		
#### Distro specific
* [NixOS](https://nixos.wiki/wiki/Main_Page)

Backup your old configuration files first
``` sh
sudo mv /etc/nixos/hardware-configuration.nix{,.bak}
sudo mv /etc/nixos/configuration.nix{,.bak}
		
sudo ln -s $(readlink -f ./machines/$(hostname)/configuration.nix) /etc/nixos/configuration.nix
```
Install git on your system
* [NixOS](https://nixos.wiki/wiki/Git)
``` sh
nix-env -iA nixos.git
```
* [Gentoo](https://wiki.gentoo.org/wiki/Git)
``` bash
sudo emerge -av dev-vcs/git
```
* [Arch](https://wiki.archlinux.org/index.php/git)
``` bash
sudo pacman -S git
```

#### Alternatively use curl
* [Gentoo](https://packages.gentoo.org/packages/net-misc/curl)
``` bash
sudo emerge -av net-misc/curl
```
* [Arch](https://wiki.archlinux.org/index.php/Autofs)
``` bash
sudo pacman -S autofs
```
### Install

Install .dotfiles tracking in your $HOME by running:
``` bash
curl -Lks bit.do/cfg_install | /bin/bash
```
This is a short url that leads to:
[dotfiles/.scripts/idot_new_cfg](https://raw.githubusercontent.com/Vaernil/dotfiles/master/.scripts/idot_new_cfg)
doesn't work atm

## Reading material for myself
* [General]
* [Linux]
	* [SSH](https://wiki.archlinux.org/index.php/Secure_Shell)
	* [SSH-keys](https://wiki.archlinux.org/index.php/SSH_keys)
* [Gentoo]
* [Arch]
## TODO
### NEW TODO
* read up on nixos, niv-env vs NixOS Configuration vs nix-shell

### OLD TODO
* tweak vim colors and change few highlight groups
* change vim airline prompt and also change colors
* try changing gtk colors so I can distinguish active chrome tabs from inactive ones, right now it's way to dark, or find a way to add an accent somehow
* write notification and popup scripts, dimensions should be based on text and geometry from where they were called from, basically I want them to show up bellow and perfectly centered, I could hardcode it, but where is the fun in that
* make dropdown menu for apps, networks, powerdown actions
* move your modified vim themes to separate files
* add custom software/dependencies?
* fn keys
* backlight
* refactor
* should I even consider uploading global config files like world or make.conf? and then how,
  symlinks? what about /etc?
* convert your modified themes to normal repos so you can load them with vimplug
* consider removing vim plugins and just do PlugInstall
* check if your scripts are POSIX, either port them or stick to #!/usr/bin/env
* port the settings to your pihole
and much more
