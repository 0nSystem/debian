#!/bin/bash

sudoers()
{
	echo "\n\n\tDime el nombre de tu usuario para meterlo en sudoers si quieres"
	read usuario
	if [ $usuario =! " " ]
	then
		echo "$usuario ALL=(ALL:ALL) ALL" >>/etc/sudoers
	fi
}
#Repositorios
repository()
{
	#repo non-free contrib
	cat /etc/apt/sources.list | sed 's/main/main contrib non-free/g' > p.txt
	cat p.txt > /etc/apt/sources.list
	#repositorio backports
	echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' >> /etc/apt/sources.list
	rm p.txt
	apt-get update -y
}
#commandos apt
apts()
{
	apt-get install -y grub-customizer wicd gmrun linux-headers-amd64 git sudo xorg slim openbox lxrandr thunar nitrogen firefox-esr tint2 vim zsh tmux obs-studio default-jdk default-jdk conky partitionmanager vlc curl rofi
}
#dpkg
driver()
{
	apt-get install -y firmware-atheros alsa-utils alsa-firmware-loaders alsa-oss alsa-tools pulseaudio-utils pulseaudio pavucontrol
	#apt-get install -y nvidia-driver blumblebee-nvidia primus-nvidia
	#gpasswd -a $usuario blumblebee
}
conf_desktop()
{
	#Config slim
	cat /etc/slim.conf | sed 's/current_theme debian_softwaves/current_theme default/g' > p.txt
	rm p.txt

	#cambiar fondo de pantalla
	#mv image.jpg /home/$usuario/.config/nitrogen/
	#nitrogen --save --set-scaled /home/$usuario/.config/nitrogen/image.jpg
	#Persistencia cuando elijamos un fondo
	echo "nitrogen --restore &">>/etc/xdg/openbox/autostart
	#Config Tint2
	cat tint2rc > /etc/xdg/tint2/tint2rc
	echo "tint2 &" >>/etc/xdg/openbox/autostart
	#Conky
	cp conky.conf /etc/conky/conky.conf
	echo "conky &">>/etc/xdg/openbox/autostart
}
if [ $(id -u) -ne 0 ]
then
	echo  -e "\n\n\t\tEntra como usuario root"
else
	repository
	apts
	sudoers
	driver
	conf_desktop
	#Reinicio
	systemctl reboot
fi
