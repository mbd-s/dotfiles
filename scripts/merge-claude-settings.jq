# Merges Claude Code settings layers into one settings.json.
#
# Input: the layer files, slurped in lexical order. $current: the existing
# settings.json. Objects merge recursively, arrays concatenate without
# duplicates, and a later layer's scalar wins. Top-level keys that no layer
# defines (model, advisorModel and other values Claude Code writes) are kept
# from $current.

def uniq_keep: reduce .[] as $x ([]; if any(.[]; . == $x) then . else . + [$x] end);

def merge($a; $b):
  if ($a | type) == "object" and ($b | type) == "object" then
    reduce ($b | keys_unsorted[]) as $k ($a;
      .[$k] = (if has($k) then merge(.[$k]; $b[$k]) else $b[$k] end))
  elif ($a | type) == "array" and ($b | type) == "array" then
    $a + $b | uniq_keep
  else $b end;

(reduce .[] as $layer ({}; merge(.; $layer))) as $merged
| $merged + ($current[0] // {} | with_entries(select(.key as $k | $merged | has($k) | not)))
