#!/usr/bin/env fish
# Taken from https://github.com/probonopd/go-appimage/blob/master/src/appimaged/README.md
# System integration for AppImages
# Remove pre-existing conflicting tools (if any)
systemctl --user stop appimaged.service; or true
sudo apt-get -y purge appimagelauncher; or true
test -f ~/.config/systemd/user/default.target.wants/appimagelauncherd.service; or rm ~/.config/systemd/user/default.target.wants/appimagelauncherd.service
# Clear cache
rm "$HOME"/.local/share/applications/appimage*
# Restart any lingering daemons cleared out above
systemctl --user daemon-reload
# Download
mkdir -p ~/Applications
wget -c https://github.com/$(wget -q https://github.com/probonopd/go-appimage/releases/expanded_assets/continuous -O - | grep "appimaged-.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2) -P ~/Applications/
chmod +x ~/Applications/appimaged-*.AppImage
# Launch
~/Applications/appimaged-*.AppImage
