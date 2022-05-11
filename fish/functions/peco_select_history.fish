function peco_select_history -d 'Fuzzy-find search history' -a query
  test (count $argv) = 0 || set -l options --query "$query"

  builtin history | peco $options | read match

  if [ $match ]
    commandline $match
  else
    commandline ''
  end
end
