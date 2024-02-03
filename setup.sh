#! /bin/bash
#
############################################################
# /etc/pacman.conf
# カラー表示とプログレスバーをパックマンにする
# 具体的には「#Color」のコメントを外し、下の行に「ILoveCandy」を追加する
############################################################
sudo sh -c "sed -i 's/#Color/Color\'$'\nILoveCandy/g' /etc/pacman.conf"

############################################################
# ~/.bashrc
############################################################
echo "
alias vim='nvim'
alias ll='ls -l'
alias la='ls -lA'
alias ..='cd ..'
alias autoremove='sudo pacman -Rsc \$(pacman -Qdtq)'
(tty | grep 'tty') > /dev/null && export LANG=C
" >> $HOME/.bashrc

############################################################
# パッケージのインストール
############################################################
sudo pacman -Sy git neovim tmux --needed --noconfirm

############################################################
# /etc/environment
# テキストエディタに Neovimを設定
############################################################
ETC_ENV="/etc/environment"
sudo sh -c "echo EDITOR=nvim >> $ETC_ENV"

############################################################
# yay-bin
############################################################
cd
git clone https://aur.archlinux.org/yay-bin
cd yay-bin
makepkg -si --noconfirm
cd
rm -rf yay-bin

############################################################
# ranger
# パッケージのインストール
# ranger（ranger本体）
# highlight（ソースコードを色分け表示）
# ueberzug（画像のプレビュー）
############################################################
sudo pacman -Sy ranger highlight ueberzug --needed --noconfirm

# 設定ファイルの作成
ranger --copy-config all

# ~/.config/ranger/rc.conf の編集
# 枠線の表示
sed -i "s/set draw_borders none/set draw_borders both/g" $HOME/.config/ranger/rc.conf
# 画像表示を「true」にする
sed -i "s/set preview_images false/set preview_images true/g" $HOME/.config/ranger/rc.conf
# 画像の表示方法に「ueberzug」を指定
sed -i "s/set preview_images_method w3m/set preview_images_method ueberzug/g" $HOME/.config/ranger/rc.conf

############################################################
# kmscon
############################################################
yay -Sy kmscon --needed --noconfirm
# tty2 に kmscon を割り当てるようにサービスを起動
sudo systemctl -f enable kmsconvt@tty2

############################################################
# CapsLock->Ctrl
############################################################

############################################################
# 日本語フォント
# sudo pacman -Sy otf-ipafont でも良い
############################################################
yay -Sy ttf-hackgen

