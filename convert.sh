#!/bin/bash
egrep -Rl '"fb"' .  | egrep -v '\.git|convert\.sh' | xargs sed -i 's|"fb"|"bw"|g'
egrep -Rl 'fb_' .   | egrep -v '\.git|convert\.sh' | xargs sed -i 's|fb_|bw_|g'
egrep -Rl 'fb\.' .  | egrep -v '\.git|convert\.sh' | xargs sed -i 's|fb\.|bw.|g'

for dir in `find . -type d -name '*fb*'`; do
  new_name=$(echo $dir | sed 's|fb_|bw_|g')
  mv $dir $new_name
done
