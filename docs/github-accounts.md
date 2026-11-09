# GitHub accounts (personal + work)

**The folder picks the account.** Nothing to switch in day-to-day use.

| Repo lives in | Commits as | Pushes with | `gh` acts as |
|---------------|------------|-------------|--------------|
| `~/workspace/work/...` | work email | work ssh key | work user (`GH_WORK_USER`) |
| anywhere else | personal email | personal ssh key | `garbray` |

## Test it

```bash
./install.sh git --check
```

Good output:

```
==> personal (expect github user: garbray)
  ✓ commit email: bryangarzonb@gmail.com
  ✓ ssh key ~/.ssh/id_rsa_personal -> garbray
  ✓ gh login: garbray
==> work (expect github user: <work-user>)
  ✓ commit email: <work email>
  ✓ ssh key ~/.ssh/<work-key> -> <work-user>
  ✓ gh login: <work-user>
==> ssh config
  ✓ IdentitiesOnly yes
  ✓ no IdentityFile under Host github.com
==> all good
```

Every `✗` line says what to fix; see [Fix](#fix). Re-run until it prints `all good`.

By hand, inside any repo:

```bash
git config user.email        # who commits
git config core.sshCommand   # which key pushes
gh api user -q .login        # who gh is (new terminal needed after setup)
```

## Switch accounts

Normally: `cd` into a repo. Inside `~/workspace/work/` you are the work account,
anywhere else personal. Each terminal follows its own directory.

Override, current terminal only:

| Command | Effect |
|---------|--------|
| `ghw` | `gh` = work account, until `gha` (any directory) |
| `ghp` | `gh` = personal account, until `gha` |
| `gha` | back to automatic |

`ghw`/`ghp` only change `gh`. Git always follows the folder: to commit or push as work,
the repo must be under `~/workspace/work/`.

Programs not started from a terminal (GUI apps) use gh's default account:
`gh auth switch --user <user>`.

## Set up a machine

1. **SSH keys**: one per GitHub account. Add each `.pub` to its account
   (GitHub -> Settings -> SSH and GPG keys). Skip if already done.
2. **`~/.ssh/config`**: `Host github.com` must have `IdentitiesOnly yes` and **no
   `IdentityFile`**:

   ```sshconfig
   Host github.com
       HostName github.com
       User git
       IdentitiesOnly yes
       AddKeysToAgent yes
       UseKeychain yes     # macOS only; drop on Linux
   ```

   Why: ssh-agent offers an `IdentityFile` from here before the key git asks for, and
   GitHub logs you in as the owner of the first key it accepts. Result: personal pushes
   go out as the work user (or the other way round).
3. **Run the git step** in a terminal (it asks questions):

   ```bash
   ./install.sh git
   ```

   It asks for, and stores outside this public repo:
   - work email and work ssh key -> `~/.config/git/work.gitconfig`
   - work GitHub username -> `export GH_WORK_USER=...` in `~/.localenv`
   - a browser `gh auth login` for each account not yet logged in
   - deleting old `~/.config/gh/hosts.yml.*` token snapshots (revoke those tokens at
     <https://github.com/settings/applications>)

   Then it runs the check.
4. Open a new terminal (loads the `gh` hook).

Re-run `./install.sh git` any time; it skips what is already done. To redo the work
identity, delete `~/.config/git/work.gitconfig` and run it again.

## Fix

| `✗` says | Fix |
|----------|-----|
| `authenticates as '<other user>'` | remove `IdentityFile` under `Host github.com` in `~/.ssh/config` |
| `authenticates as 'nothing'` | key not added to GitHub, or wrong key path |
| `ssh key ... does not exist` | wrong path: edit `~/.config/git/work.gitconfig` (work) |
| `no commit email` (work) | `~/.config/git/work.gitconfig` missing: `./install.sh git` |
| `no github user` | `./install.sh git`, or add `export GH_WORK_USER=<user>` to `~/.localenv` |
| `gh not logged in as <user>` | `gh auth login`, pick that account in the browser |
| `remove 'IdentityFile ...'` | delete that line under `Host github.com` |

Other symptoms:

| Symptom | Fix |
|---------|-----|
| `ERROR: Repository not found` on push | wrong account; run the check |
| `gh` is the wrong account in a terminal | opened before setup: new terminal; or a `ghw`/`ghp` pin: `gha` |
| `ghAccount: no gh login for '<user>'` | `gh auth login` for that account |
| work repo outside `~/workspace/work/` | move it there |

## How it works

- **Commits + pushes**: `~/.gitconfig` includes
  `~/.config/git-accounts/personal.gitconfig` (default), then, for repos under
  `~/workspace/work/`, `work.gitconfig`, which includes the machine-local
  `~/.config/git/work.gitconfig`. Each sets `user.email` and
  `core.sshCommand = ssh -i <key> -o IdentitiesOnly=yes`. `insteadOf` turns
  `https://github.com/` remotes into ssh (all in work, only `garbray/*` elsewhere), so
  keychain HTTPS credentials never pick the account.
- **gh**: `~/.config/zsh/ghAccount` runs on every `cd` and exports `GH_TOKEN` for the
  folder's account, read from gh's keyring (`gh auth token --user`). Per terminal; every
  program started from it (nvim, Claude Code, scripts) inherits it, and can read it.

| File | In repo | Holds |
|------|---------|-------|
| `dotfiles/common/.config/git-accounts/personal.gitconfig` | yes | personal email, key |
| `dotfiles/common/.config/git-accounts/work.gitconfig` | yes | https->ssh rewrite, include |
| `dotfiles/common/.config/zsh/ghAccount` | yes | gh hook, `ghw`/`ghp`/`gha` |
| `install/common/git.sh` | yes | setup + `--check` |
| `~/.config/git/work.gitconfig` | no | work email, work key |
| `~/.localenv` | no | `GH_WORK_USER` |

Work email, key name and username stay out of the repo because it is public.
