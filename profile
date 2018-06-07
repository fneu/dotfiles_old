# Polkit authentication for giving privileges to applications
lxsession &

# Let qt apps use gtk theme:
export QT_QPA_PLATFORMTHEME=gtk2
# Let's use kvantum instead to make them look better:
export QT_STYLE_OVERRIDE=kvantum

# Don't switch off monitors completely
# Needed because Displayport-using monitors never come back on again
xset -dpms &

# Add ruby gems to path
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin:$HOME/.local/bin:$HOME/.bin"

