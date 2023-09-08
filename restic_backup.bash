#! /usr/bin/env bash

restic -r rclone:onedrive:restic-backups --verbose --exclude-file $HOME/configs/rclone_exclude backup ~/
