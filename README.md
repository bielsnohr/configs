# Matthew Bluteau's Configuration Files

## TODO

- [ ] A default Python environment with some base packages installed
  - pipx
  - probably want to move to something like `uv` or `pyenv` for this
- [ ] Move away from using omf because it is no longer maintained
- [ ] Move AppImage setup to ansible
- [ ] automatically add key shortcut for Keepass autocomplete
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

If the default terminal application isn't set by installing terminator as part
of the above, then it can manually be set through this interactive command:

```bash
update-alternatives --config x-terminal-emulator
```

### Syncthing

There doesn't seem to be a good ansible role for this available, so just
manually go through the steps at <https://apt.syncthing.net/>. To get
auto-start working, see the `Makefile`.

### AppImages

KeePassXC and Obsidian rely on AppImages. The Ansible install step will install
the prerequisites for running these easily. There is system integration step
that makes using these more like other applications. The steps are in the
Makefile under `appimaged`.

### Android Studio

Download tar file from <https://www.jetbrains.com/toolbox-app/> to
`~/Applications/`. Extract it and then run the executable (it is an AppImage).
This should auto-add the executable to relevant locations and make a desktop
entry.

