#!/bin/sh

# Apply keyboard settings from one place.
#
# i3 runs each exec_always command concurrently, so having a separate
# `setxkbmap` call per option is racy: every call writes the XKB options
# property, and whichever one finishes last overwrites the other. On a fresh
# X session that often left only one option applied until the next reload.
#
# Do both options in a single setxkbmap invocation (the empty -option clears
# stale options left in the X session), then set the repeat rate afterwards.

apply_keyboard_settings() {
  setxkbmap -option '' -option terminate:ctrl_alt_bksp,caps:escape
  xset r rate 300 50
}

apply_keyboard_settings

# On a fresh X session libinput can register the real keyboard devices just
# after i3 starts. Re-apply once shortly afterwards so those devices get the
# settings too. The marker keeps this from repeating on every config reload.
marker="${XDG_RUNTIME_DIR:-/tmp}/i3-keyboard-initialized"
if [ ! -e "$marker" ]; then
  : >"$marker"
  sleep 2
  apply_keyboard_settings
fi
