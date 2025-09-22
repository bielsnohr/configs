#!/usr/bin/env fish
# Lamentably, the snap and flatpak firefox cause issues with password
# manager integrations. Use the deb for the time being.
# Get rid of any current versions of firefox first
sudo snap remove firefox
sudo apt remove --yes firefox
sudo add-apt-repository --yes ppa:mozillateam/ppa
printf "\nPackage: firefox* \nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001\n\n" | sudo tee /etc/apt/preferences.d/mozilla
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:noble";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
sudo apt install --yes firefox
