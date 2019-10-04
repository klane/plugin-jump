function jump
  if test (count $argv) -ne 1
    echo "Usage: jump <MARK_NAME>"
  else
    if test -d $MARKPATH/$argv[1] -a -L $MARKPATH/$argv[1]
      cd (readlink $MARKPATH/$argv[1])
    else
      set -l exists false
      for root in (command ls $MARKPATH | string match '*.root')
        if test -d $MARKPATH/$root -a -L $MARKPATH/$root -a -d $MARKPATH/$root/$argv[1]
          set exists true
          cd (readlink $MARKPATH/$root)/$argv[1]
        end
      end

      if not $exists
        echo "No such mark: $argv[1]"
      end
    end
  end
end
