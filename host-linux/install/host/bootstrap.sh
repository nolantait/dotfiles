$target=$1

$target_files=$HOME/dotfiles/host-linux/install/target

echo "Copying files to target machine"
scp -r $target_files root@$target:~
echo "Files copied"
