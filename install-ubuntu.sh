#!/bin/bash
echo "Ubuntu After install part"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install ubuntu-restricted-extras tlp tlp-rdw gnome-tweak-tool curl zsh gcc cmake valgrind python3 python3-pip luarocks tree-sitter-cli isort black fd-find repgrep php composer ffmpeg libavcodec-dev libavfilter-dev libavutil-dev libavformat-dev libavcodec-dev libavfilter-dev libavutil-dev libavformat-dev libglib2.0-dev libcurl4-openssl-dev valgrind chrome-gnome-shell -y

echo "Install NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

echo "Install LazyGit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

echo "Install Nvim"
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

echo "Install nopde js"
nvm install --lts

echo "Dokcer post installation steps"
sudo usermod -aG docker $USER 
sudo systemctl enable docker.service 
sudo systemctl enable containerd.service

echo "ZSH installation steps"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Create Wrok and Project folders"
cd && mkdir Work && mkdir Projects

npm install -g eslint_d yarn vscode-langservers-extracted typescript typescript-language-server intelephense diagnostic-languageserver stylelint-lsp neovim

composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs

