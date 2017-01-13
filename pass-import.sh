#!/usr/bin/env bash

if [[ -f ~/pass_public.key && -f ~/pass_private.key ]]; then

echo "Pass git repository URL: "
read GIT_REPO

gpg --import pass_public.key

gpg --import pass_private.key

#Get GPG key ID

GPG_ID=$(gpg ~/pass_private.key |  grep ssb | cut -d"/" -f2 | cut -d" " -f1 | head -1)

else 

echo "Please name pass GPG keys as ~/pass_private.key and ~/pass_public.key"


fi
