#!/bin/bash
egrep -Rl '"fb"' .  | egrep -v '\.git|convert\.sh' | xargs sed -i 's|"fb"|"bw"|g'
egrep -Rl 'fb_' .   | egrep -v '\.git|convert\.sh' | xargs sed -i 's|fb_|bw_|g'
egrep -Rl 'fb\.' .  | egrep -v '\.git|convert\.sh' | xargs sed -i 's|fb\.|bw.|g'

for dir in `find . -type d -name '*fb*' | egrep -v '\.git'`; do
  new_name=$(echo $dir | sed 's|fb_|bw_|g')
  mv $dir $new_name
done

for file in `find . -type f -name '*fb*' | egrep -v '\.git'`; do
  new_name=$(echo $file | sed 's|fb|bw|g')
  mv $file $new_name
done
