# shellcheck shell=bash
# Shared helpers, sourced by install.sh and the step scripts.

GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

log() { printf "${GREEN}==>${RESET} %s\n" "$*"; }
warn() { printf "${YELLOW}warn:${RESET} %s\n" "$*" >&2; }

# macos | omarchy | unsupported
detect_os() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        echo macos
    elif [[ -d "$HOME/.local/share/omarchy" ]]; then
        echo omarchy
    else
        echo unsupported
    fi
}

# Move whatever stow would collide with out of the way. Only the top-level
# entries of a package are checked (~/.zshrc, ~/.config/nvim, ~/.local/bin/x),
# so a pre-existing config dir (e.g. omarchy's LazyVim) is moved whole instead
# of being merged file by file.
backup_conflicts() {
    local pkg_dir="$1" backup="$2" rel target dest
    while IFS= read -r rel; do
        target="$HOME/$rel"
        if [[ -L "$target" ]]; then
            # broken link (e.g. left over from an old repo layout): drop it
            [[ -e "$target" ]] || { rm "$target"; continue; }
            # already ours: stow --restow handles it
            [[ "$(realpath "$target")" == "$REPO"/* ]] && continue
        elif [[ ! -e "$target" ]]; then
            continue
        fi
        dest="$backup/$rel"
        mkdir -p "$(dirname "$dest")"
        mv "$target" "$dest"
        warn "moved existing ~/$rel to $dest"
    done < <(
        cd "$pkg_dir" || exit
        find . -mindepth 1 -maxdepth 1 ! -name .config ! -name .local | sed 's|^\./||'
        [[ -d .config ]] && find .config -mindepth 1 -maxdepth 1
        [[ -d .local/bin ]] && find .local/bin -mindepth 1 -maxdepth 1
        true
    )
}
