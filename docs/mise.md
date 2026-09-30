# mise — Runtime Version Manager

Replaces volta, nvm, and pyenv with a single tool. Manages Node, Python, Go, Ruby, and more.

## Installation

```sh
curl https://mise.run | sh
```

Then add to `.zshrc`:

```sh
eval "$(mise activate zsh)"
```

## .tool-versions

The repo ships a `.tool-versions` at the root defining the baseline runtimes:

```
nodejs lts
python latest
go latest
```

Run `mise install` once after setup to install all of them.

## Common Commands

```sh
# install all runtimes defined in .tool-versions
mise install

# install a specific runtime
mise install node@22
mise install python@3.12

# set the global default version
mise use --global node@lts
mise use --global python@latest

# set a version for the current directory only (writes to .tool-versions)
mise use node@20

# list installed runtimes
mise list

# see what's active in the current shell
mise current

# run a command with a specific version without switching globally
mise exec node@18 -- node --version
```

## Per-project Versions

Drop a `.tool-versions` in any project directory:

```
nodejs 20.11.0
python 3.11.4
```

mise automatically activates those versions when you `cd` into that directory.

## Migrating from old managers

| Old tool | mise equivalent |
|---|---|
| `nvm use 18` | `mise use node@18` |
| `nvm install --lts` | `mise install node@lts` |
| `volta pin node@20` | `mise use node@20` (writes .tool-versions) |
| `pyenv global 3.12` | `mise use --global python@3.12` |
| `pyenv local 3.11` | `mise use python@3.11` |

## Uninstalling old managers

Once mise is working, clean up:

```sh
# remove nvm
rm -rf "$NVM_DIR"

# remove volta
rm -rf "$VOLTA_HOME"

# remove pyenv
rm -rf "$(pyenv root)"
```
