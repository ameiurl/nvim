#!/bin/bash

# xsel共用粘贴板
echo '[*] pacman installing python3 neovim nodejs npm xsel lua ripgrep'
sudo pacman -S python3 neovim nodejs npm xsel lua

# echo '[*] install pip';
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py install --upgrade pip -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com

echo '[*] pip installing Neovim'
pip3 install neovim trash-cli

echo '[*] npm installing instant-markdown-d'
sudo npm -g install yarn neovim instant-markdown-d

# 判断是否有nvim文件夹，没有则创建
echo '[*] Preparing Neovim config directory ...'
if [ ! -d "~/.config/nvim/autoload" ]; then
	mkdir -p ~/.config/nvim/autoload
fi

if ! [ -e ~/.config/nvim/autoload/plug.vim ]; then
	echo "[*] Installing vim-plug"
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	# git clone https://github.com/junegunn/vim-plug
	# cp vim-plug/plug.vim  ~/.config/nvim/autoload/plug.vim
fi

nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall'


echo -e "[+] Done"
