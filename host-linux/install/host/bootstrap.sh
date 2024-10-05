TARGET=$1
TARGET_FILES=$HOME/dotfiles/host-linux/install/target

echo "Copying files to target machine"
scp -r $TARGET_FILES root@$TARGET:~
echo "Files copied"
