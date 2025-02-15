# Makefile for Matthew Bluteau's configuration on Ubuntu
# TODO my use of the `cd` command within make is incorrect because make creates
# a new shell for each command. So, I either need to run scripts for some of
# these steps, or look into another way for the current directory to be passed
# between steps
# TODO it looks like an `install.sh` script is the preferred method for GitHub
# dotfiles, so convert this to a shell script

IPYTHON_CONFIG = ~/.ipython/profile_default/ipython_config.py
.PHONY: install-omf fish-default-shell powerline-font gvim

# TODO add check of vim/gvim version before doing this to avoid
# unnecessary install
gvim: powerline-font
	# Install big GUI vim from package manager
	sudo apt update && sudo apt install --yes vim-gtk3
	# Other dependencies
	sudo apt install --yes build-essential cmake python3-dev 
	# Install then run Vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

powerline-font:
	# Install patched fonts for powerline
	git clone https://github.com/powerline/fonts.git --depth=1
	cd fonts && ./install.sh
	rm -rf fonts

appimaged:
	@# System integration for AppImages
	@# Remove pre-existing conflicting tools (if any)
	systemctl --user stop appimaged.service || true
	sudo apt-get -y purge appimagelauncher || true
	[ -f ~/.config/systemd/user/default.target.wants/appimagelauncherd.service ] && rm ~/.config/systemd/user/default.target.wants/appimagelauncherd.service
	@# Clear cache
	rm "$HOME"/.local/share/applications/appimage*
	@# Restart any lingering daemons cleared out above
	systemctl --user daemon-reload
	@# Download
	mkdir -p ~/Applications
	wget -c https://github.com/$(wget -q https://github.com/probonopd/go-appimage/releases/expanded_assets/continuous -O - | grep "appimaged-.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2) -P ~/Applications/
	chmod +x ~/Applications/appimaged-*.AppImage
	# Launch
	~/Applications/appimaged-*.AppImage

ukaea:
	# Set up split vpn
	git clone git@git.ccfe.ac.uk:mjuvonen/vpn_ukaea.git ~/src/vpn_ukaea
	cd ~/src/vpn_ukaea
	echo "Please modify to use your shortname."
	vim bin/vpn_ukaea
	sudo make install
	cd

ipython:
	python -m pip install --user ipython
ifeq ("$(wildcard $(IPYTHON_CONFIG))","")
	ipython profile create
endif
	# uncomment relevant line in config file
	sed -i -E 's/^\#\s*(c\.TerminalInteractiveShell\.editing_mode\s+=).*/\1 "vi"/' \
		$(IPYTHON_CONFIG)

syncthing_autostart:
ifeq ("$(wildcard ~/.config/autostart/.)","")
	mkdir ~/.config/autostart
endif
	cp /usr/share/applications/syncthing-start.desktop ~/.config/autostart/

pureline:
	cd &&  git clone git@github.com:chris-marsh/pureline.git
	ln -s ~/configs/.pureline.conf ~/.pureline.conf

git-lfs:
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
	sudo apt install git-lfs

bundler:
	@# If ruby is updated, then my local bundle installation will break. It is a simple fix.
	gem install bundler

fix-imagemagick-policy:
	@# For some reason, Ubuntu comes with certain GhostScript profiles
	@# disabled for ImageMagick (and therefore convert won't work).
	sudo sed -i_bak \
	       	's/rights="none" pattern="PDF"/rights="read | write" pattern="PDF"/' \
		/etc/ImageMagick-6/policy.xml

clean-imagemagick-policy:
	sudo mv /etc/ImageMagick-6/policy.xml_bak /etc/ImageMagick-6/policy.xml

load-terminal-profiles:
	dconf load /org/gnome/terminal/legacy/ < ~/configs/gnome_terminal_profiles.txt 

python-poetry:
	pipx install poetry
	poetry completions fish > ~/.config/fish/completions/poetry.fish
	
fish-default-shell:
	sudo add-apt-repository ppa:fish-shell/release-3
	sudo apt update
	sudo apt install fish=3.7.1-1~jammy
	# somehow fish is able to pick up PATH values set by bashrc, so no need
	# for anything further
	chsh -s $(which fish)

install-omf: fish-default-shell
	curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install-omf
	fish install-omf --path=~/.local/share/omf --config=~/.config/omf

npm:
	curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
	sudo bash nodesource_setup.sh
	sudo apt update
	sudo apt install nodejs

gitmoji: npm
	mkdir -p $HOME/.npm-global/bin
	fish_add_path $HOME/.npm-global/bin
	npm config set prefix ~/.npm-global
	npm i -g gitmoji-cli

firefox:
	@# Lamentably, the snap and flatpak firefox cause issues with password
	@# manager integrations. Use the deb for the time being.
	@# Get rid of any current versions of firefox first
	sudo snap remove firefox
	sudo apt remove firefox
	sudo add-apt-repository ppa:mozillateam/ppa
	echo '\nPackage: firefox* \nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001\n\n' | sudo tee /etc/apt/preferences.d/mozilla
	echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
	sudo apt install firefox

nodejs:
	curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
	sudo bash /tmp/nodesource_setup.sh
	sudo apt install nodejs
	curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
	echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

yarn: nodejs
	sudo apt-get update && sudo apt-get install yarn

actual-finance: yarn
	git clone https://github.com/actualbudget/actual-server.git
	cd actual-server
	yarn install
	yarn start

zotero:
	wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
	sudo apt update
	sudo apt install zotero

flatpak:
	sudo apt install flatpak
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	flatpak install flathub com.github.tchx84.Flatseal

