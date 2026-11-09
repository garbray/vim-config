#!/usr/bin/env bash
set -euo pipefail
source "$REPO/install/lib.sh"

log "configuring taskwarrior"
data="$HOME/.local/share/task"
mkdir -p "$data"

# included by .taskrc, which errors if it's missing
if [[ ! -e "$data/sync.rc" ]]; then
    printf '# sync.server.url=http://<server>:8080\n# sync.server.client_id=<uuid>\n# sync.encryption_secret=<secret>\n' >"$data/sync.rc"
    warn "fill in $data/sync.rc to enable sync (docs/task-warrior-sync.md)"
fi
chmod 600 "$data/sync.rc"

# one-time move of the db that used to live in the repo
old="$REPO/dotfiles/common/.config/task-warrior/taskchampion.sqlite3"
if [[ -f "$old" && ! -e "$data/taskchampion.sqlite3" ]]; then
    cp "$old" "$data/"
    log "copied task db to $data"
fi

job="*/15 * * * * \$HOME/.local/bin/task-sync >/dev/null 2>&1"
current="$(crontab -l 2>/dev/null || true)"
if ! grep -qF "task-sync" <<<"$current"; then
    printf '%s\n%s\n' "$current" "$job" | sed '/^$/d' | crontab -
    log "added task-sync cron job (every 15 min)"
fi
