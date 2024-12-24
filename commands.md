# Lazygit commands:

```
lazygit // open lazygit

# Multiple gh accounts

Add a new ssh

```
ssh-keygen -t rsa -b 4096 -C "your-email"

```

In the ssh folder create a config file with the following

```
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa

Host alias
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_another

```

ssh-add path-to-ssh-key

test your ssh

```
ssh -T your-alias

```
