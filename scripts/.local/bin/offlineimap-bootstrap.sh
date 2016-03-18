#!/bin/bash
source ~/.gnupg/gpg-agent-info-*
export GPG_AGENT_INFO=$GPG_AGENT_INFO
gpg-cache-passphrase.sh 9D56BDEB675E5181451A5000A86F19F625998B2F
exec offlineimap
