# Executed only once when the user logs in

# .bashrc is only read by a shell that's both interactive and non-login.
#
# Interactive Shell: This means the shell is started with the intention of
# interacting with a user. It's waiting for commands to be typed in and
# executed in real-time (like when you open a terminal window and get a prompt
# to type commands). You can see if a shell is interactive by checking if it
# has standard input, output, and error streams connected to a terminal (TTY).
#
# Non-login Shell: A non-login shell is one that is not started as a "login
# session." This typically happens when you start a terminal emulator (e.g.,
# GNOME Terminal, iTerm) or run a new shell from an existing shell (bash, zsh
# etc.). In this case, the shell doesn’t ask for a login and doesn’t
# read the files associated with login shells (e.g., /etc/profile,
# ~/.bash_profile, ~/.profile).
#
# A non-login, interactive shell is typically what you get when you open a
# terminal window on your desktop or start a new shell within another shell. It
# allows you to interact with the system by typing commands but doesn't require
# or perform the login process.
#
# Anyways, in those cases we want to source our original bashrc file
[[ -r ~/.bashrc ]] && . ~/.bashrc
