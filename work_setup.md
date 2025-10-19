# Work Setup Steps

## Restic Backups

1. Configure `rclone` using the wizard: `rclone config`. Most of the defaults
   should be fine. The `~/.config/rclone.conf` file should look like:

   ```
   [onedrive]
   type = onedrive
   token = {"access_token":"created_by_auth_step"}
   drive_id = b!Q5YrEtTxwEuNUNHZ4-vUiGS9ogGmq45Hg6b_iT4fJ6ByxiFgvSJKSIADB6_lBCCR
   drive_type = business
   ```
2. Run the backup from terminal (script should be in path): `restic_backup.bash`.

## Restoring from Restic Backup

To restore a my `~/work/` from the OneDrive backup, use:

```bash
restic -r rclone:onedrive:restic-backups restore --target ~/work/ latest:/home/mbluteau/work/
```

When moving to a new machine, it probably isn't worth doing anything more than
that.

## VPN

This should be done by the `work_playbook.yml`; however, make sure you have exchanged SSH keys with GitLab before doing so.
This requires access to the GitLab Web UI, so you will probably need to be on site to do this.

```bash
ansible-playbook --ask-become-pass --verbose work_playbook.yml
```

## Printing

TODO check the setup that Harry figured out.

## MS Teams

Must be accessed through a Chromium based browser to work properly. I just use
the Chromium snap: `snap install chromium`, which unfortunately doesn't connect
to KeePassXC, but neither does the AppImage version.

Within Chromium, search for Teams and log in.
Once using Teams within Chromium, you should get a pop-up offering to install the PWA.
Install the PWA, which will create a desktop app entry for the Teams PWA.

## Outlook

Access through Firefox is fine.

## Conda

Use the version called [`miniforge`](https://github.com/conda-forge/miniforge),
which ensures that you don't use Anaconda channels to avoid any licence nasties.
The installer is super simple. Decline the shell initialisation since this should already be handled by other configs.
