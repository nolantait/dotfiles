# Setting up a new machine

1. Install `asdf` from AUR `paru -S asdf-vm`
2. Add ruby plugin `asdf plugins add ruby`
3. Install the latest ruby `asdf install ruby latest`
4. Add version to .tool-versions `asdf global ruby X.X.X`
5. Install system gems:
    - `gem install rails`
    - `gem install amazing_print`
6. Check for messages about updating like `gem update --system 3.4.22`

# Configuration files

These files configure various parts of the ruby ecosystem:

- `./rspec` for managing tests
- `./railsrc` for changing what a `rails new` command uses
- `./irbrc` for upgrading the default `irb` experience
- `./gemrc` for removing documentation from gem downloads
