source /usr/share/cachyos-fish-config/cachyos-config.fish
set PATH "$HOME/.config/composer/vendor/bin:$PATH"
set QT_IM_MODULES "wayland;fcitx;ibus"

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end


# Added by Antigravity CLI installer
set -gx PATH "/home/azaujla/.local/bin" $PATH
