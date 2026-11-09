# GitHub accounts (personal + work)

The account is picked from the directory; no manual switching.

| Where | git author + ssh key | `gh` account |
|-------|----------------------|--------------|
| `~/workspace/work/**` | work (`~/.config/git/work.gitconfig`) | `$GH_WORK_USER` |
| anywhere else | personal (`garbray`) | `garbray` |

## How it works

Three separate things decide "which account", and each is handled:

1. **Commit author** - `~/.gitconfig` includes
   `~/.config/git-accounts/personal.gitconfig`, then
   `includeIf "gitdir:~/workspace/work/"` includes `work.gitconfig`, which overrides it.
2. **git push/pull** - each include sets `core.sshCommand` to one key with
   `IdentitiesOnly=yes`, so ssh-agent can't offer the other account's key first
   (GitHub authenticates you as whoever owns the first accepted key). `insteadOf`
   rewrites `https://github.com/` remotes to ssh (all of them in work repos, only
   `garbray/*` elsewhere), so HTTPS remotes don't depend on keychain credentials.
3. **gh CLI** - `~/.config/zsh/ghAccount` runs on every `cd` and exports `GH_TOKEN`
   for the right account, read from gh's own keyring login (`gh auth token --user`).
   It is per shell: two terminals can be on different accounts. Anything started from
   that shell (nvim, Claude Code, scripts) inherits it.

Files:

- `dotfiles/common/.config/git-accounts/{personal,work}.gitconfig` (repo)
- `dotfiles/common/.config/zsh/ghAccount` (repo, sourced by `.zshrc`)
- `~/.config/git/work.gitconfig` (machine-local: work email + work key)
- `~/.localenv` (machine-local: `export GH_WORK_USER=<work-github-user>`)

Work email, work key name and work username stay out of this repo because it is public.

## Setup on a machine

`./install.sh setup` (or just this step: `REPO=$PWD bash install/common/git.sh`) does
everything it can. Run it in a terminal; it prompts, and only warns when not
interactive. Safe to re-run: it skips what is already done.

| Does | Prompts / writes |
|------|------------------|
| `~/.gitconfig` includes | personal default + `includeIf` for `~/workspace/work/` |
| work identity | work email + work ssh key -> `~/.config/git/work.gitconfig` |
| gh hook user | work github username -> `GH_WORK_USER` in `~/.localenv` |
| gh logins | runs `gh auth login --web` for each account not logged in |
| old setup | removes `gh personal`/`gh work` aliases, offers to delete `hosts.yml.*` snapshots |
| checks | ssh keys exist, `IdentitiesOnly yes` for `Host github.com` |

Manual, the script can't do it:

1. SSH keys: one per account, each public key added to its GitHub account
   (Settings -> SSH and GPG keys).
2. `~/.ssh/config` (the script only checks it):

   ```sshconfig
   Host github.com
       HostName github.com
       User git
       IdentitiesOnly yes
       # no IdentityFile: git picks the key via core.sshCommand

   # optional, for old remotes like git@personal:garbray/x
   Host personal
       HostName github.com
       User git
       IdentityFile ~/.ssh/id_rsa_personal
       IdentitiesOnly yes
   ```

3. If old `hosts.yml.*` snapshots existed: revoke their tokens at
   <https://github.com/settings/applications>.
4. Open a new shell, keep work repos under `~/workspace/work/`.

## Check

```bash
cd ~/workspace/work/<repo>
git config user.email            # work email
git config core.sshCommand       # work key
gh api user -q .login            # work user
ssh -T -i ~/.ssh/<work-key> -o IdentitiesOnly=yes git@github.com   # "Hi <work-user>!"

cd ~/workspace/personal/<repo>   # same commands -> personal values
```

## Commands

| Command | Does |
|---------|------|
| `ghw` | this shell uses work account (stays until `gha`) |
| `ghp` | this shell uses personal account |
| `gha` | back to automatic (by directory) |
| `gh auth switch --user <u>` | default account for programs not started from zsh |

## Troubleshooting

| Symptom | Cause / fix |
|---------|-------------|
| `ERROR: Repository not found` on push | wrong key used; check `git config core.sshCommand` in that repo, repo is under the right dir |
| commit has personal email in work repo | `~/.config/git/work.gitconfig` missing; rerun `install/common/git.sh` |
| `ghAccount: no gh login for '<user>'` | `gh auth login` for that account |
| `gh` uses wrong account | `echo $GH_TOKEN` empty? `GH_WORK_USER` unset in `~/.localenv`; or a `ghw`/`ghp` pin, run `gha` |
| `gh auth status` shows a token from `GH_TOKEN` | expected; the env token wins over the keyring default |
| repo outside `~/workspace/work/` should be work | move it, or add another `includeIf` for that path in `~/.gitconfig` |

Old setup (`gh personal`/`gh work` copying `hosts.yml.*` snapshots) is removed: each
snapshot held one account, so copying it made gh forget the other login.
