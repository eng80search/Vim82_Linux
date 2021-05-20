#!/bin/sh

# 概要
# Vimの必要な環境を構築するため、このファイルを実行した後、
# Vimを立ち上げてPlugInstallを実行してPluginをインストールする

# 実行方法
# chmod 755 ./vim.sh
# ./vim.sh

ln -sf ~/00_Git/01_Vim/.vimrc ~/.vimrc

ln -sf ~/00_Git/01_Vim/00_Vimrc ~/.vim/00_Vimrc
ln -sf ~/00_Git/01_Vim/autoload ~/.vim/autoload

# 必要なフォルダを作成する（既に存在する場合は、スキップされる）
mkdir -p ~/.vim/backUp
mkdir -p ~/.vim/swp
mkdir -p ~/.vim/undo

cp -rf ./viminfo.txt ~/.vim/viminfo.txt
