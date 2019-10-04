function marks
  if test (count $argv) -gt 0
    echo "Usage: marks"
  else
    set -l file_list (command ls $MARKPATH)
    if test (count $file_list) -eq 0
      echo "No marks currently defined."
    else
      set -l mark_list
      for file in $file_list
        if test -d $MARKPATH/$file -a -L $MARKPATH/$file
          set mark_list $mark_list $file
        end
      end
      if test (count $mark_list) -eq 0
        echo "No marks currently defined."
      else
        set -l output ""
        for mark_name in $mark_list
          if string match -q "*.root" $mark_name
            for entry in (command ls $MARKPATH/$mark_name)
              if test -d $MARKPATH/$mark_name/$entry
                set -l real_path (readlink $MARKPATH/$mark_name)/$entry
                set output "$output$entry -> $real_path"\n
              end
            end
          else
            set -l real_path (readlink $MARKPATH/$mark_name)
            set output "$output$mark_name -> $real_path"\n
          end
        end
        echo $output | sort | column -t
      end
    end
  end
end
