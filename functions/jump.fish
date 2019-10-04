function jump
  if test (count $argv) -ne 1
    echo "Usage: jump <MARK_NAME>"
  else
    if test -d $MARKPATH/$argv[1] -a -L $MARKPATH/$argv[1]
      cd (readlink $MARKPATH/$argv[1])
    else
      for root in (command ls $MARKPATH | string match '*.root')
        if test -d $MARKPATH/$root -a -L $MARKPATH/$root -a -d $MARKPATH/$root/$argv[1]
          cd (readlink $MARKPATH/$root)/$argv[1]
          return
        end
      end

      echo "No such mark: $argv[1]"
    end
  end
end
