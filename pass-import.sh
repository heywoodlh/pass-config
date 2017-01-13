#!/usr/bin/env bash

# Check if dependencies are met before running
DEPS=(pass)
for i in $DEPS; do
  command -v $i >/dev/null 2>&1 || { error >&2 "Please install $i first"; exit 1; }
done


if [[ -f ~/.pass_public.key && -f ~/.pass_private.key ]]; then

echo "Pass git repository URL: "
read GIT_REPO

gpg --import ~/.pass_public.key

gpg --import ~/.pass_private.key

#Get GPG key ID

GPG_ID=$(gpg ~/.pass_private.key |  grep ssb | cut -d"/" -f2 | cut -d" " -f1 | head -1)

pass init $GPG_ID

pass git init

pass git remote add origin $GIT_REPO

pass git pull origin master

printf "\n"

echo "Delete key files? (y/N)"
read RESPONSE

if [[ $RESPONSE == [yY] ]]; then 
 rm ~/.pass_p*
fi

printf "\n"
echo "Complete!"

else 

echo "Please name pass GPG keys as such: ~/.pass_private.key and ~/.pass_public.key"


fi
