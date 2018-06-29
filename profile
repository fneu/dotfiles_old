# Let qt apps use gtk theme:
export QT_QPA_PLATFORMTHEME=gtk2
# Let's use kvantum instead to make them look better:
export QT_STYLE_OVERRIDE=kvantum
# Add ruby gems to path
export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin:$HOME/.local/bin"

