# SYNOPSIS
#   Completions for jump package.

complete -c jump -f -a "(command ls ~/.marks | string match --invert '*.root'
                        and find ~/.marks/*.root/ -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)"
complete -c unmark -n '__fish_not_contain_opt -s r root' -f -a '(command ls ~/.marks)'
complete -c unmark -n '__fish_contains_opt -s r root' -f -a "(command ls ~/.marks | string replace --filter '.root' '')"
