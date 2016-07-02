#!/bin/bash
egrep -Rl '"fb"' . | egrep -v '\.git' | xargs sed -i 's|"fb"|"bw"|g'
egrep -Rl 'fb_' .  | egrep -v '\.git' | xargs sed -i 's|fb_|bw_|g'

