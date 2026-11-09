# GitHub accounts (personal + work)

**The folder picks the account.** Nothing to switch in day-to-day use.

| Repo lives in | Commits as | Pushes with | `gh` acts as |
|---------------|------------|-------------|--------------|
| `~/workspace/work/...` | work email | `~/.ssh/github_work` | work user (`GH_WORK_USER`) |
| anywhere else | personal email | `~/.ssh/github_personal` | `garbray` |

## Test it

```bash
./install.sh git --check
```

Good output:

```
==> personal (expect github user: garbray)
  ✓ commit email: bryangarzonb@gmail.com
  ✓ ssh key ~/.ssh/github_personal -> garbray
  ✓ gh login: garbray
==> work (expect github user: <work-user>)
  ✓ commit email: <work email>
  ✓ ssh key ~/.ssh/github_work -> <work-user>
  ✓ gh login: <work-user>
==> ssh config
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

1. **`~/.ssh/config`**: `Host github.com` must have **no `IdentityFile`** (or no
   `Host github.com` block at all). Fine to keep:

   ```sshconfig
   Host github.com
       HostName github.com
       User git
       AddKeysToAgent yes
       UseKeychain yes     # macOS only; drop on Linux
   ```

   Why: ssh-agent offers an `IdentityFile` from here before the key git asks for, and
   GitHub logs you in as the owner of the first key it accepts. Result: personal pushes
   go out as the work user (or the other way round).
2. **Run the git step** in a terminal (it asks questions):

   ```bash
   ./install.sh git
   ```

   It does, skipping whatever is already done:
   - asks the work email -> `~/.config/git/work.gitconfig` (not in this public repo)
   - asks the work GitHub username -> `export GH_WORK_USER=...` in `~/.localenv`
   - browser `gh auth login` for each account not logged in yet
   - **ssh keys** `~/.ssh/github_personal` and `~/.ssh/github_work`: for each missing
     one it lists your existing keys and either symlinks the one you name
     (`github_work -> id_old_name`) or generates a new ed25519 key; then, if the public
     key is not on that GitHub account yet, uploads it (`gh ssh-key add`)
   - offers to delete old `~/.config/gh/hosts.yml.*` token snapshots (revoke those
     tokens at <https://github.com/settings/applications>)
   - runs the check
3. Open a new terminal (loads the `gh` hook).

Re-run `./install.sh git` any time. To redo something, delete it and re-run:
`~/.config/git/work.gitconfig` (work email), `~/.ssh/github_<account>` (+ `.pub`) for a
key (deleting a symlink leaves the original key alone).

## Fix

| `✗` says | Fix |
|----------|-----|
| `authenticates as '<other user>'` | remove `IdentityFile` under `Host github.com` in `~/.ssh/config` |
| `authenticates as 'nothing'` | key not on GitHub: `./install.sh git` uploads it |
| `ssh key ... does not exist` | `./install.sh git` in a terminal creates or links it |
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
  `~/.config/git/work.gitconfig` (work email only). Each sets `user.email` and
  `core.sshCommand = ssh -i ~/.ssh/github_<account> -o IdentitiesOnly=yes`. `insteadOf` turns
  `https://github.com/` remotes into ssh (all in work, only `garbray/*` elsewhere), so
  keychain HTTPS credentials never pick the account.
- **gh**: `~/.config/zsh/ghAccount` runs on every `cd` and exports `GH_TOKEN` for the
  folder's account, read from gh's keyring (`gh auth token --user`). Per terminal; every
  program started from it (nvim, Claude Code, scripts) inherits it, and can read it.

| File | In repo | Holds |
|------|---------|-------|
| `dotfiles/common/.config/git-accounts/personal.gitconfig` | yes | personal email, key |
| `dotfiles/common/.config/git-accounts/work.gitconfig` | yes | work key, https->ssh rewrite, include |
| `dotfiles/common/.config/zsh/ghAccount` | yes | gh hook, `ghw`/`ghp`/`gha` |
| `install/common/git.sh` | yes | setup + `--check` |
| `~/.config/git/work.gitconfig` | no | work email |
| `~/.ssh/github_{personal,work}` | no | ssh keys (file or symlink) |
| `~/.localenv` | no | `GH_WORK_USER` |

Work email and username stay out of the repo because it is public.
