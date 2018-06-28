# Let qt apps use gtk theme:
QT_QPA_PLATFORMTHEME=gtk2
# Let's use kvantum instead to make them look better:
QT_STYLE_OVERRIDE=kvantum
# Add ruby gems to path
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin:$HOME/.local/bin"

