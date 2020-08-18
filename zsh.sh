#!/bin/bash
zsh-config()
{
	echo -e "\n\t${color_magenta}Configuracion ${color_rojo}OhMyZsh${color_reset}\n"
	if [ -d ~/.oh-my-zsh ]
	then
		echo -en "\t\t[${color_verde}V${color_reset}]"
	else
		echo -ne "\t\t[${color_rojo}X${color_reset}]"
		wget -O ~/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh &> /dev/null
		chmod +x ~/install.sh
		xterm +hold -e 'sh ~/install.sh' &
		wait $!
		rm -f ~/install.sh
	fi
	echo -e "\tOhMyZsh"
	#Autosuggestions
	if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]
	then
		echo -ne "\t\t[${color_verde}V${color_reset}]"
	else
		echo -ne "\t\t[${color_rojo}X${color_reset}]"
		git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions &> /dev/null
	fi
	echo -e "\tAutosuggestions"
	#zsh-syntax
	if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]
	then
		echo -ne "\t\t[${color_verde}V${color_reset}]"
	else
		echo -ne "\t\t[${color_rojo}X${color_reset}]"
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &> /dev/null
	fi
	echo -e "\tSyntax-Highlighting"
	#Añadir plugins
	if [ -d ~/.oh-my-zsh ]
	then
		cat ~/.zshrc | sed 's/plugins=(git)/plugins=(git colored-man-pages colorize extract tmux zsh-autosuggestions zsh-syntax-highlighting)/;s/ZSH_THEME="robbyrussell"/ZSH_THEME="gnzh"/' > ~/zsh.conf
		rm -f ~/.zshrc && mv ~/zsh.conf ~/.zshrc
		echo "set -g mouse on" > ~/.tmux.conf
		sed 's/ZSH_TMUX_AUTOSTART:=false/ZSH_TMUX_AUTOSTART:=true/' ~/.oh-my-zsh/plugins/tmux/tmux.plugin.zsh > ~/conf.txt
		mv ~/conf.txt ~/.oh-my-zsh/plugins/tmux/tmux.plugin.zsh
	fi
	#powerline
	sudo apt-get install -y powerline
	echo "source /usr/share/powerline/bindings/tmux/powerline.conf" >> ~/.tmux.conf
}

zsh-config
