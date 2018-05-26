# Polkit authentication for giving privileges to applications
lxsession &

# Let qt apps use gtk theme:
export QT_QPA_PLATFORMTHEME=gtk2

# Don't switch off monitors completely
# Needed because Displayport-using monitors never come back on again
xset -dpms &
