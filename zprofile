# DOCS: .zlogin and .zprofile do the same thing. They set the environment for
# login shells. The only difference is they just get loaded at different times.
# This is the place to put user facing env variables
#
# WARN: Apple terminal initially opens both a login and an interactive shell even
# though you don't authenticate (i.e., enter login credentials). That’s why
# .zshrc will always be loaded. However, after the first terminal session, any
# subsequent shells that are opened are only interactive; thus .zprofile will
# not be loaded.
