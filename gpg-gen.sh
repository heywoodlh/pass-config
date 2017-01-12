#!/usr/bin/env bash

### All content below this line is unnecessary ### 

auth() {
if [ -e ~/.cfze ]
then 
  echo "Overwrite current authentication? y/N"
  read RESPONSE 
      if [[ "$RESPONSE" == [Nn] ]]
	then exit
      fi
  echo "API Key: "
  read API_KEY  

  rm -f ~/.cfze

  printf "EMAIL=$EMAIL \nAPI_KEY=$API_KEY" > ~/.cfze
  chmod 500 ~/.cfze

else
  
  echo "API Key: "
  read API_KEY


  printf "EMAIL=$EMAIL \nAPI_KEY=$API_KEY" > ~/.cfze
  chmod 500 ~/.cfze 
fi
}


### All content above this line is unnecessary ###



echo "Email: "
read EMAIL


USERNAME=$(whoami)

echo "Encrypt using GPG? (y/N)"
read RESPONSE

if [[ $RESPONSE == [Nn] ]]
 then auth

else 

echo "Full name: "
read REAL_NAME

cat >~/tmp.txt <<EOF
     %echo Generating a standard key
     Key-Type: RSA
     Key-Length: 1024
     Subkey-Type: ELG-E
     Subkey-Length: 1024
     Name-Real: $REAL_NAME
     Name-Email: $EMAIL
     Expire-Date: 0
     %pubring /home/$USERNAME/.cfze-gpg.pub
     %secring /home/$USERNAME/.cfze-gpg.sec
     # Do a commit here
     %commit
     %echo done
EOF

gpg --batch --gen-key ~/tmp.txt

rm ~/tmp.txt

gpg --import /home/$USERNAME/.cfze-gpg.pub > /dev/null 2>&1
gpg --import /home/$USERNAME/.cfze-gpg.sec > /dev/null 2>&1 

fi

#GREP FOR GPG ID
GPG_ID=$(gpg ~/.cfze-gpg.sec |  grep ssb | cut -d"/" -f2 | cut -d" " -f1)

gpg --edit-key $GPG_ID trust save

pass init $GPG_ID
