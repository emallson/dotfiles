#!/bin/bash
echo "SETDESC Cache private key password for mail
SETPROMPT Password:
GETPIN" | pinentry-gtk-2 | grep D | cut -d\  -f2- | /usr/lib/gnupg/gpg-preset-passphrase --preset $1
