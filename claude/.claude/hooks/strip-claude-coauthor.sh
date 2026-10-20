#!/usr/bin/env bash
# PostToolUse: strips a "Co-Authored-By: ... Claude ..." trailer from the commit
# a Bash command just created. Claude Code injects that trailer from its own
# built-in default (a session-start system-reminder), which contradicts the
# no-Co-Authored-By rule in ~/.claude/CLAUDE.md. Setting includeCoAuthoredBy
# false in settings.json is the primary fix; this is the backstop for when a
# session carries the default anyway.
#
# Only ever rewrites a commit that no remote ref contains, so a published commit
# is left alone rather than being silently diverged from its remote. Skips any
# repo mid-rebase, mid-merge or mid-cherry-pick, where amending HEAD would
# rewrite the wrong thing.
#
# The repo is taken from every `git -C <path>` in the command plus the shell's
# own directory, since a commit can land somewhere other than cwd.
set -uo pipefail

input=$(cat)
[ "$(printf '%s' "$input" | jq -r '.tool_name // ""')" = Bash ] || exit 0
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // ""')
[ -z "$cmd" ] && exit 0

# Cheap pre-filter: only commands that could have produced a commit.
printf '%s' "$cmd" | grep -Eq '(^|[^[:alnum:]_-])git([^[:alnum:]_-]|$)' || exit 0
printf '%s' "$cmd" | grep -Eq '(commit|merge|revert|cherry-pick|rebase|am)' || exit 0

TRAILER_RE='^[[:space:]]*co-authored-by:.*claude'

# Candidate directories: every `git -C <path>`, plus cwd.
dirs=$(printf '%s' "$cmd" \
  | grep -oE '\-C[[:space:]]+("[^"]+"|'"'"'[^'"'"']+'"'"'|[^[:space:]]+)' \
  | sed -E 's/^-C[[:space:]]+//; s/^"//; s/"$//; s/^'"'"'//; s/'"'"'$//')
dirs=$(printf '%s\n%s\n' "$dirs" "$(pwd -P)")

seen=""
while IFS= read -r d; do
  [ -z "$d" ] && continue
  top=$(git -C "$d" rev-parse --show-toplevel 2>/dev/null) || continue
  case "$seen" in *"|$top|"*) continue ;; esac
  seen="$seen|$top|"

  git -C "$top" rev-parse --verify HEAD >/dev/null 2>&1 || continue

  # An in-progress rebase/merge/cherry-pick means HEAD is not the commit the
  # author is working on; amending it there rewrites the wrong commit.
  gitdir=$(git -C "$top" rev-parse --git-dir 2>/dev/null) || continue
  case "$gitdir" in /*) : ;; *) gitdir="$top/$gitdir" ;; esac
  for marker in rebase-merge rebase-apply MERGE_HEAD CHERRY_PICK_HEAD REVERT_HEAD BISECT_LOG; do
    [ -e "$gitdir/$marker" ] && continue 2
  done

  msg=$(git -C "$top" log -1 --format=%B 2>/dev/null) || continue
  printf '%s' "$msg" | grep -Eiq "$TRAILER_RE" || continue

  # Refuse to rewrite anything a remote already has.
  if [ -n "$(git -C "$top" for-each-ref --contains HEAD --format='%(refname)' refs/remotes 2>/dev/null)" ]; then
    printf 'strip-claude-coauthor: HEAD in %s carries a Claude Co-Authored-By trailer but is already on a remote; left as is.\n' "$top"
    continue
  fi

  # Command substitution strips the trailing newlines the removed trailer leaves,
  # so the blank line that separated it from the body goes with it.
  cleaned=$(printf '%s\n' "$msg" | grep -Eiv "$TRAILER_RE")
  [ -z "$cleaned" ] && continue

  if printf '%s\n' "$cleaned" | git -C "$top" commit --amend --no-verify --quiet -F - 2>/dev/null; then
    printf 'strip-claude-coauthor: removed a Claude Co-Authored-By trailer from HEAD in %s.\n' "$top"
  fi
done <<< "$dirs"

exit 0
