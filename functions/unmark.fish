function unmark
  argparse --name=mark 'r/root' -- $argv
  or return

  if test (count $argv) -eq 0
    echo "Usage: unmark <MARK_NAME>..."
  else
    for mark_name in $argv
      if set -q _flag_root
        and test -d $MARKPATH/$mark_name.root -a -L $MARKPATH/$mark_name.root
        command rm -i $MARKPATH/$mark_name.root
      else if test -d $MARKPATH/$mark_name -a -L $MARKPATH/$mark_name
        command rm -i $MARKPATH/$mark_name
      else
        echo "No such mark: $mark_name"
      end
    end
  end
end
