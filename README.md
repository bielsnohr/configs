# Matthew Bluteau's Configuration Files

## TODO

- A default Python environment with some base packages installed
  - pipx
  - probably want to move to something like `uv` or `pyenv` for this
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

## New System Installation Steps

1. Install git and clone this repo:

    ```bash
    sudo apt update && sudo apt install --yes git
    git clone https://github.com/bielsnohr/configs.git
    ```

2. Run dotbot to put configuration files in place:

    ```bash
    cd configs && ./install
    ```

3. Install ansible:

    ```bash
    sudo apt update && sudo apt install --yes python3-pip pipx
    pipx ensurepath
    pipx install --include-deps ansible
    ```

4. Run ansible playbook:

    ```bash
    # Add `--check` argument to see what the effects will be before actually
    # executing them
    ansible-playbook --ask-become-pass --verbose playbook.yml
    ```
    
