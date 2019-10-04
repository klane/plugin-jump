function mark
  argparse --name=mark 'r/root' -- $argv
  or return

  if test (count $argv) -eq 0 -o (count $argv) -gt 2
    echo "Usage: mark <MARK_NAME> [DIRECTORY]"
  else if set -q _flag_root
    set -l root (basename $argv[1])
    if test -e $MARKPATH/$root.root
      if test -d $MARKPATH/$root.root -a -L $MARKPATH/$root.root
        echo "A root mark named $root already exists."
      else
        echo "$MARKPATH/$root.root already exists."
      end
    else if test (count $argv) -eq 1
      _link $argv[1] $root.root
    else
      echo "Root folder mark naming not supported."
    end
  else if test -e $MARKPATH/$argv[1]
    if test -d $MARKPATH/$argv[1] -a -L $MARKPATH/$argv[1]
      echo "A mark named $argv[1] already exists."
    else
      echo "$MARKPATH/$argv[1] already exists."
    end
  else if test (count $argv) -eq 1
    command ln -s (pwd) $MARKPATH/$argv[1]
  else if test (count $argv) -eq 2
    _link $argv[2] $argv[1]
  end
end

function _link
  if test -d $argv[1]
    set -l current_dir (pwd)
    cd $argv[1]
    command ln -s (pwd) $MARKPATH/$argv[2]
    cd $current_dir
  else
    echo "$argv[1] is not a valid directory."
  end
end
