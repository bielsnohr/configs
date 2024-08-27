# Matthew Bluteau's Configuration Files

TODO:

- Dotbot conversion
  - Add remaining files to be linked by looking at those in home folder
  - A very basic setup is most of the way there. Fish and omf work when installed in conjunction
    with the Makefile. In order to use dotbot, the command is `git clone $url && cd dotfiles && ./install`
  - .pystartup -> ~/.pystartup
- automatically add key shortcut for Keepass autocomplete
- default terminal application is set by `update-alternatives --config x-terminal-emulator`, however
  this does mean its icon doesn't display quite properly, which is minor
- additional shortcut for opening terminal is set in dconf
  `org.gnome.settings-daemon.plugins.media-keys="['<Primary><Alt>t', '<Primary><Alt>n']"`
- UKAEA specific config
  - VPN script, clone it into my user space
  - Network configuration
- implement interim solution for keyboard in Makefile
  - the command line way per-user: `gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"`
  - edit the file `/etc/default/keyboard` to have the line
    `XKBOPTIONS="ctrl:swapcaps"`
  - be careful that there might be options already set, so this should be
    appended rather than overwriting the whole line
- use of `ukaea_mount.sh` requires creation of `~/linux_{home,work}`, so put
  this in makefile as well

## Automatic Backups

- 2022-08-08
  - This is all a bit of a mess at the moment
  - It would appear I lost all of the modifications I made on the backup_data.sh script for my new system
    - I need to make a variable for the user name and propagate that to all of the relevant other paths
    - then, put this in `~/.local/bin`
  - The `backup-data.service` file needs to go at `/etc/systemd/system/backup-data.service` and then run
    ```bash
    sudo systemctl start backup-data.service
    sudo systemctl enable backup-data.service
    # you might need to do a `sudo systemctl daemon-reload`
    ```
  - Also, it looks like the backup 2021-04-25 has not completed because a lot of
    the directories are empty. I should probably just do a full backup.

## Obsolete

- setxkbmap.desktop -> ~/.config/autostart/setxkbmap.desktop (to set keyboard
  mappings)
  - Update 2020-02-18: this isn't really a solution because it is reset
    whenever a new keyboard is connected or when hibernate/sleep is entered
    - better solution above, old notes below
  - this was an absolute palaver to figure out
  - Wayland screws around with GDM which itself screws with Xorg and Xsession
    loading, making it nearly impossible to set anything X-related on a
    per-user (let alone system wide) basis
  - Therefore, the easiest route was to make a simple startup application file
    that gets reliably executed at login
