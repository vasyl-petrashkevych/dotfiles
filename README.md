# Dotfiles

### Mangaro

```bash
sudo pacman -S alacritty ttf-meslo-nerd flameshot polybar rofi php php-apache php-cgi php-fpm php-gd  php-embed php-intl php-redis php-snmp composer
blueberry pavucontrol zscroll rofi-power-menu
```

#### For neovim

```bash
pamac install lua-language-server fish lazygit docker docker-compose bat clang python-pip cmake-language-server
```

## For .zshrc or .bashrc

```bash
alias nv="nvim"
alias nvo="nvim ."
alias nvc="nvim ~/.config/nvim/init.lua"
```

## Dependencies

```bash
npm install -g vscode-langservers-extracted typescript typescript-language-server intelephense diagnostic-languageserver stylelint-lsp
```

## PHP Dependencies

````bash
composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
```### Fedora

```bash
copr enable atim/lazygit -y
sudo dnf install zsh flameshot nvim blueman-manager pavucontrol lazygit network-manager-applet nm-connection-editor nm-connection-editor-desktop nmtui
````
