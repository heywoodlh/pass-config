pass-config

DESCRIPTION: Simple, interactive configuration scripts for configuring pass (http://passwordstore.org) 

gpg-gen.sh - Generates GPG keys and initializes pass using those keys. 

pass-import.sh - Helps user easily connect password-store to remote repository, import GPG keys, initialize pass using imported GPG keys and pull password-store from remote repository. Uses git for versioning control


DIRECTIONS:

gpg-gen.sh - 

1. Execute gpg-gen.sh and answer prompts

pass-import.sh - 

1. Place GPG private and public keys in home directory. Name them as such: ~/.pass_public.key and ~/.pass_private.key. 

2. Execute pass-import.sh and answer prompts


After either script has been run pass will be ready for use.

Do not use both scripts on the same system.
