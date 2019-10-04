function jump
  if test (count $argv) -ne 1
    echo "Usage: jump <MARK_NAME>"
  else
    if test -d $MARKPATH/$argv[1] -a -L $MARKPATH/$argv[1]
      cd (readlink $MARKPATH/$argv[1])
    else
      set -l exists false
      for project in (command ls -d $MARKPATH/*.root)
        if test -d $project -a -L $project -a -d $project/$argv[1]
          set exists true
          cd (readlink $project)/$argv[1]
        end
      end

      if not $exists
        echo "No such mark: $argv[1]"
      end
    end
  end
end
