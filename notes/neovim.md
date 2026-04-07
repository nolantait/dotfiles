# Using multiple configs

One way is to use the `NVIM_APPNAME` environment variable to specify a different
config directory.

```
mkdir -p ~/.config/nvim-next
mkdir -p ~/.local/share/nvim-next
mkdir -p ~/.local/state/nvim-next
mkdir -p ~/.cache/nvim-next
```

Then you can run nvim with that appname.

```
NVIM_APPNAME=nvim-next nvim
```
