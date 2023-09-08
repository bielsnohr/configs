# Makefile for Matthew Bluteau's configuration on Ubuntu
# TODO my use of the `cd` command within make is incorrect because make creates
# a new shell for each command. So, I either need to run scripts for some of
# these steps, or look into another way for the current directory to be passed
# between steps
# TODO it looks like an `install.sh` script is the preferred method for GitHub
# dotfiles, so convert this to a shell script

IPYTHON_CONFIG = ~/.ipython/profile_default/ipython_config.py

# TODO add check of vim/gvim version before doing this to avoid
# unnecessary install
gvim:
	# Install big GUI vim from package manager
	sudo aptitude update && sudo aptitude install vim-gtk3
	# Other dependencies
	sudo aptitude install build-essential cmake python3-dev 
	# Install then run Vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	# YouCompleteMe requires an extra installation step
	cd ~/.vim/bundle/YouCompleteMe
	/usr/bin/python3 install.py --clang-completer
	cd
	# Install patched fonts for powerline
	git clone https://github.com/powerline/fonts.git --depth=1
	cd fonts
	./install.sh
	cd ..
	rm -rf fonts

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

onedrive:
	sudo aptitude install build-essential libcurl4-openssl-dev libsqlite3-dev pkg-config git curl libnotify-dev
	curl -fsS https://dlang.org/install.sh | bash -s dmd
	# this only works if there is only one installation of dmd compiler
	# present
	source ~/dlang/dmd-2.0*/activate
	cd ~/src
	git clone https://github.com/abraunegg/onedrive.git
	cd onedrive
	./configure --enable-notifications --enable-completions
	make clean; make;
	sudo make install
	deactivate
	cd
	echo "Visit https://github.com/abraunegg/onedrive/blob/master/docs/USAGE.md for details on authorisation steps and usage."

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
	curl -sSL https://install.python-poetry.org | python3 -
	poetry completions bash | sudo tee /etc/bash_completion.d/poetry > /dev/null

fish-default-shell:
	sudo apt install fish
	# somehow fish is able to pick up PATH values set by bashrc, so no need
	# for anything further
	chsh -s $(which fish)

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
