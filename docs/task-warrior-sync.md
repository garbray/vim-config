# Taskwarrior Sync Server (LAN)

One central server on the local network; every machine keeps a full local replica and
runs `task sync` to exchange changes. Works offline, syncs when back on the LAN.

Taskwarrior 3.x uses **taskchampion-sync-server**. The old `taskd` / Taskserver and the
`taskd.*` settings are Taskwarrior 2.x only and do not work with 3.x.

Tasks are encrypted on the client with `sync.encryption_secret` before upload; the
server only stores ciphertext. Plain HTTP on a trusted LAN is acceptable for that
reason. Use HTTPS if the server is ever exposed outside the LAN.

```
 laptop ─┐
 desktop ┼── task sync ──► http://taskserver.lan:8080  (taskchampion-sync-server, SQLite)
 omarchy ┘
```

## 1. Server

Any always-on box with Docker (NAS, Raspberry Pi, home server). Give it a fixed IP
(DHCP reservation in the router) or a hostname like `taskserver.lan`.

Generate a client ID once. It is shared by **all** your machines (one ID = one task
list), so save it in your password manager:

```bash
uuidgen | tr 'A-Z' 'a-z'
```

Copy `server/taskchampion/` from this repo to the server, then:

```bash
cd taskchampion
echo "CLIENT_ID=<client-id>" > .env   # only this ID may sync; comma-separate for more
docker compose up -d
docker compose logs -f              # should show it listening on 0.0.0.0:8080
```

From another machine, check it is reachable:

```bash
curl -i http://taskserver.lan:8080/   # any HTTP response (even 404) = reachable
```

Firewall: allow TCP 8080 from the LAN only. Do not port-forward it on the router.

### Backup

The whole database is the `data` volume. Back it up with:

```bash
docker run --rm -v taskchampion_data:/data -v "$PWD":/backup alpine \
  tar czf /backup/taskchampion-$(date +%F).tgz -C /data .
```

Each client also has a full copy, so losing the server only loses unsynced history.

## 2. Client config (every machine)

`./install.sh setup` (step `install/common/taskwarrior.sh`) does the local part:

- creates `~/.local/share/task/` (task data, outside the repo)
- creates `~/.local/share/task/sync.rc` (mode 600) with commented placeholders;
  `.taskrc` includes it, and Taskwarrior errors if it is missing
- copies the old in-repo `taskchampion.sqlite3` there once, if present
- adds a cron job running `~/.local/bin/task-sync` every 15 min; the wrapper
  is a no-op until `sync.rc` has a `sync.server.url`

Secrets stay out of the repo. Fill in `~/.local/share/task/sync.rc`:

```ini
sync.server.url=http://taskserver.lan:8080
sync.server.client_id=<client-id>
sync.encryption_secret=<secret>
```

Generate the secret once (`openssl rand -hex 32`) and reuse the **same** value on every
machine. Store it in the password manager: lose it and the server copy is unreadable.

## 3. First sync (machine with the existing tasks)

Do this on the machine that already has your tasks, before any other machine syncs:

```bash
task count                 # note the number
task sync                  # uploads everything
```

## 4. Add another machine

```bash
./install.sh               # packages, link, setup (empty replica + sync.rc + cron)
$EDITOR ~/.local/share/task/sync.rc
task sync
task count                 # same as the first machine
```

Do not copy a `taskchampion.sqlite3` between machines; let sync populate it.

## 5. Keep in sync

Cron runs `task-sync` every 15 min. Run `task sync` (or `task-sync`) by hand for an
immediate sync; `taskwarrior-tui` has no auto-sync. Check the job with `crontab -l`.

## History: data used to live in the repo

Before this setup `data.location` pointed into the stowed repo and
`taskchampion.sqlite3` was committed (git was the sync). It is now untracked and
gitignored, but still in git history; rewrite history if the repo is public and the
tasks are private. On another machine with an old clone, `git pull` deletes the
in-repo copy: run `./install.sh setup` there **before** pulling if it has tasks not
on this machine, or just sync from scratch.

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `Could not read include file` | run `./install.sh setup` (creates `~/.local/share/task/sync.rc`) |
| connection refused / timeout | server down, wrong host/port, firewall; test with `curl` |
| 403 / unauthorized client | `client_id` not in server `CLIENT_ID` list |
| decryption error | `sync.encryption_secret` differs between machines |
| `task undo` refuses | expected: synced changes cannot be undone |

Check effective config: `task show sync`. Reference: `man task-sync`,
<https://gothenburgbitfactory.org/taskchampion-sync-server/>.
