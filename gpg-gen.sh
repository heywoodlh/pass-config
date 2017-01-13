#!/usr/bin/env bash

echo "Email: "
read EMAIL

echo "Full name: "
read REAL_NAME

echo "Passphrase: "
read PASSPHRASE

cat >~/tmp.txt <<EOF
     %echo Generating a standard key
     Key-Type: RSA
     Key-Length: 1024
     Subkey-Type: ELG-E
     Subkey-Length: 1024
     Name-Real: $REAL_NAME
     Name-Email: $EMAIL
     Expire-Date: 0
     Passphrase: $PASSPHRASE
     %pubring /home/$USERNAME/.pass-gpg.pub
     %secring /home/$USERNAME/.pass-gpg.sec
     # Do a commit here
     %commit
     %echo done
EOF

gpg --batch --gen-key ~/tmp.txt

gpg --import /home/$USERNAME/.pass-gpg.pub > /dev/null 2>&1
gpg --import /home/$USERNAME/.pass-gpg.sec > /dev/null 2>&1 


#GREP FOR GPG ID
GPG_ID=$(gpg ~/.pass-gpg.sec |  grep ssb | cut -d"/" -f2 | cut -d" " -f1)

gpg --edit-key $GPG_ID trust save

pass init $GPG_ID

#Clean up temp files

rm /home/$USERNAME/.pass-gpg.*

rm ~/tmp.txt
