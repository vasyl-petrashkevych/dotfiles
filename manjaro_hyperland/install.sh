#!/bin/bash
echo "Manjaro After install part"
# sudo pacman-mirrors --fasttrack
sudo pacman -Syyu && sudo systemctl enable fstrim.timer && sudo systemctl start fstrim.timer  
sudo pacman -S pavucontrol ufw gufw neovim kitty hyprland hyprpaper dunst pipewire waybar ranger rofi xdg-desktop-portal-hyprland flameshot stow bitwarden alacritty ttf-meslo-nerd php php-apache php-cgi php-fpm php-gd  php-embed php-intl php-redis php-snmp blueman composer repgrep a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv opus wavpack x264 xvidcore

sudo pamac install lua-language-server fish lazygit docker docker-compose docker-buildx bat clang python-pip valgrind polkit polkit-kde-agent polkit-qt5 lib32-polkit vls

sudo ufw enable && sudo systemctl enable ufw

echo "Install NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

LINE='if [[ -f ~/.config/myzshrc.zsh ]]; then source ~/.config/myzshrc.zsh fi'
# Check if it's already in .zshrc
if ! grep -q 'source ~/.config/myzshrc.zsh' ~/.zshrc; then
  printf "\n# Load custom zsh config\n%s\n" "$LINE" >> ~/.zshrc
  echo "✅ Custom zsh config added to ~/.zshrc"
else
  echo "ℹ️  Entry already exists in ~/.zshrc"
fi

echo "Reload .zshrc"
source ~/.zshrc

echo "Install nopde js"
nvm install --lts

echo "Dokcer post installation steps"
sudo usermod -aG docker $USER 
sudo systemctl enable docker.service 
sudo systemctl enable containerd.service

echo "Configure ssh keys"
chmod 644 ~/.ssh/*
chmod 600 ~/.ssh/work
chmod 600 ~/.ssh/id_rsa

echo "Create Wrok and Project folders"
cd && mkdir Work && mkdir Projects

echo "Clone dotfiles"
git clone git@github.com:vasyl-petrashkevych/dotfiles.git

npm install -g yarn vscode-langservers-extracted typescript typescript-language-server intelephense diagnostic-languageserver stylelint-lsp

composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs

cd ../ && stow manjaro_hyperland nvim alacritty backgrounds fonts idevimrc
