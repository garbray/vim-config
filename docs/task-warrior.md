# Taskwarrior Cheat Sheet

Taskwarrior 3.x. Config: `dotfiles/common/.config/task-warrior/.taskrc`, picked up via
`TASKRC` in `.zshrc`. Data: `~/.local/share/task` (not in repo). TUI: `taskwarrior-tui`.
Sync across machines: see
[task-warrior-sync.md](task-warrior-sync.md).

Command shape: `task [filter] <command> [modifications]`. No filter on `modify`/`done`/
`delete` = Taskwarrior asks to confirm for every task.

## Add

```bash
task add Write project report due:friday priority:H project:work +writing
task add Pay rent due:eom recur:monthly          # recurring (needs due)
task add Submit report depends:12                # blocked until 12 done
task add Renew passport wait:2026-12-01          # hidden until wait date
task add Call bank scheduled:tomorrow            # "ready" from that date
task log Fixed the printer                       # add already-completed task
```

Priority: `H` `M` `L` (or none). Tags: `+tag` add, `-tag` remove.

## Dates

| Value | Meaning |
|-------|---------|
| `today` `tomorrow` `yesterday` | midnight of that day |
| `monday` .. `sunday` | next one |
| `eod` `eow` `eom` `eoy` | end of day/week/month/year |
| `sow` `som` `soy` | start of week/month/year |
| `now+3d` `due-2d` | relative (`d` `w` `mo` `y` `h` `min`) |
| `2026-12-01` `2026-12-01T09:00` | ISO |

Attributes: `due:` deadline, `scheduled:` earliest start, `wait:` hide until,
`until:` auto-delete after.

## Modify / complete

```bash
task 3 modify priority:M due:2026-11-15
task 3 modify +urgent -someday             # tags
task 3 modify Updated description          # bare words replace description
task 3 modify due:                         # clear attribute
task 3 annotate "link: https://..."        # add note
task 3 edit                                # open in $EDITOR
task 3 start / task 3 stop                 # mark active (+ACTIVE)
task 3 done                                # complete
task 3,5,7 done                            # several
task 3-6 done                              # range
task 3 delete
task undo                                  # revert last change (not after sync)
task 3 duplicate due:tomorrow
```

## Filters

```bash
task project:work list                     # project and subprojects (work.api)
task +urgent list
task -work list                            # without tag
task priority:H due.before:eow list
task description.contains:report list
task /regex/ list
task "(project:work or +urgent)" list
task status:completed end.after:today-7d all
```

Virtual tags (computed, no need to add): `+OVERDUE` `+DUE` (soon) `+TODAY` `+WEEK`
`+ACTIVE` `+BLOCKED` `+BLOCKING` `+WAITING` `+READY` `+TAGGED` `+ANNOTATED`.

## Reports

| Command | Shows |
|---------|-------|
| `task` / `task next` | most urgent first (default) |
| `task list` / `task ls` | pending, compact |
| `task ready` | actionable now (not waiting/scheduled later/blocked) |
| `task active` | started |
| `task overdue` | past due |
| `task waiting` | hidden by `wait:` |
| `task blocked` / `task blocking` | dependency chains |
| `task recurring` | recurring templates |
| `task completed` | done tasks |
| `task all` | everything incl. deleted |
| `task 3 info` | every field + change history |
| `task projects` / `task tags` | counts |
| `task summary` | % complete per project |
| `task calendar` | month view with due dates |
| `task burndown.weekly` | progress chart |
| `task history.monthly` | added/done/deleted per month |
| `task reports` | list all reports |

## Contexts

Persistent filter, applied to every report and to new tasks.

```bash
task context define work project:work
task context define home "-work"
task context work
task context none
task context list
```

## Review routine

- Daily: `task next`, start one thing (`task N start`), `task overdue`.
- Weekly: `task summary`, `task waiting`, `task +BLOCKED`, re-prioritize, clear stale.

## Misc

```bash
task show <setting>                        # current config value
task config <name> <value>                 # write to .taskrc
task _get 3.uuid                           # one field (scripting)
task export project:work > work.json       # JSON export
task import tasks.json
task diagnostics                           # version, config, data paths
```

IDs change as tasks complete; use the UUID (`task _get 3.uuid`) in scripts.
