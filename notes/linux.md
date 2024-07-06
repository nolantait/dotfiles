# Setting up a new machine

Programs to install:

- **paru**: Better system package management
- **rcm**: Dotfile management with system links
- **htop**: Better `top`
- **polybar**: Top bar with widgets
- **dunst**: Desktop notifications
- **conky**: Lightweight system monitor
- **alacritty**: GPU accelerated terminal
- **spotify-edge**: Music
- **firefox**: Browser
- **nvidia**: Nvidia drivers
- **pavucontrol**: Sound and volume control
- **i3-scrot**: Screeshot utility
- **dmenu**: Program launcher
- **lsof**: Monitor ports
- **the_silver_searcher**: Grep
- **bat**: Better `cat`
- **eza**: Better `ls`
- **gh**: Github management

Set up dotfiles and git

```
git clone https://github.com/nolantait/dotfiles.git
gh auth
```

Then run rcup

```
cd ~/dotfiles
env RCRC=$HOME/dotfiles/rcrc rcup -B linux
```
