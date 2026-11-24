# Pair programming with upterm

Upterm runs an SSH server next to your shell on this machine and dials *out* to
a relay. Guests connect to the relay, which tunnels the session back to you, so
there are no inbound ports on your laptop and no `pair` user or extra sshd.

We run our own relay so session traffic does not pass through a third party.

`RELAY_HOST` below is a placeholder. The address is deliberately kept out of
this public repo; get it from the private Ansible inventory.

| Piece | Where |
| --- | --- |
| Relay (`uptermd`) | `RELAY_HOST:2222` |
| Host script | `~/dotfiles/bin/pair-program` |
| Client | `upterm` from Homebrew (keep it in step with the relay) |

## Starting a session

```console
pair-program --server RELAY_HOST
```

Restrict who can join to a collaborator's published keys instead of your own
`authorized_keys`:

```console
pair-program --server RELAY_HOST --guest github:alice
```

The script runs, roughly:

```console
upterm host \
  --server ssh://RELAY_HOST:2222 \
  --authorized-keys ~/.ssh/authorized_keys \
  --force-command 'tmux attach -t pair-programming' \
  --no-exec --no-sftp --no-forwarding \
  --join-timeout 10m --hide-client-ip \
  -- tmux new -A -s pair-programming
```

- `tmux new -A -s pair-programming` creates the shared session, or attaches to it
  if it is already running. Use `-s` (name); `-t` is tmux's target/group option.
- `--force-command` makes each guest's shell land in that tmux session.
- `--no-exec --no-sftp --no-forwarding` deny guests extra commands, file
  transfer, and port forwarding.
- `--join-timeout 10m` ends the session if nobody joins, so a link you post and
  forget does not stay live forever.
- Override with `PAIR_JOIN_TIMEOUT`, `PAIR_TMUX_SESSION`,
  `PAIR_AUTHORIZED_KEYS`.

Share the `➤ Join:` or `➤ SSH:` line that upterm prints. Treat it as a secret:
recent upterm versions include a per-session token, and anyone who has both the
line and an authorized key can join.

A guest can join with upterm or plain ssh:

```console
upterm join ssh://SESSION@RELAY_HOST:2222
ssh SESSION@RELAY_HOST -p 2222
```

### If the relay key changes

If you intentionally rotate the key, get the new public key from the relay and
replace both lines for `[RELAY_HOST]:2222` in `~/.ssh/known_hosts`:

```console
ssh ansible@RELAY_HOST 'sudo cat /etc/upterm/server_key.pub'
```

If it changes without you rotating it, stop and investigate before accepting.

## Client upkeep

```console
brew upgrade --cask upterm
```

## Tips

- `upterm session current` inside tmux needs the admin env var carried into the
  session. Add to `~/.tmux.conf`:
  ```conf
  set-option -ga update-environment " UPTERM_ADMIN_SOCKET UPTERM_SESSION_NAME"
  ```
- `upterm attach NAME` reattaches a detached session; `~.` detaches.
- Host logs live in `~/.local/state/upterm/upterm.log`; the script uses
  `--hide-client-ip`. The log is readable by your user, so `chmod 600` it if
  guest addresses should not be visible to other local users.
