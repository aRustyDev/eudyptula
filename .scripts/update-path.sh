#!/usr/bin/env bash

# Look for the unique string
grep "BEGIN SET BY EUDYPTULA" ~/.bashrc
# If its not found
if [ $? -ne 0 ]; then
# Add this block
echo <<EOF >> ~/.bashrc
# BEGIN SET BY EUDYPTULA
PATHS=("/usr/local/go/bin" "$HOME/.local/bin" "/opt/google-cloud-sdk/bin")
delimiter=":"
IFS="$delimiter"
JOINED_PATHS="${PATHS[*]}"

# Clean up PATH
for p in "${PATHS[@]}"; do
    export PATH=$(echo $PATH | sed 's|:$p||g')
done

# Update PATH
PATH=$PATH:$JOINED_PATHS
# END SET BY EUDYPTULA
EOF
    source ~/.bashrc
    echo "~/.bashrc updated successfully"
else
    source ~/.bashrc
    echo "~/.bashrc already updated"
fi
