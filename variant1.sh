function house_keeping(){
	#Updating System
	sudo yum update -y
	
	#Setting up epel repo and bash completion just in case
	sudo yum install epel-release -y
	sudo yum install bash-completion bash-completion-extras net-tools wget -y 
	source /etc/profile.d/bash_completion.sh
	
	#Installing RPM fusion
	sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm -y
}

function xfce_setup(){
	
	#Installing Xwindows system 
	sudo yum groupinstall "X Window System" -y
	
	#Installing and seting up XFCE 
	sudo yum --enablerepo=epel groups install "Xfce" -y 
	echo "exec /usr/bin/xfce4-session" >> ~/.xinitrc
	
	#For XRDP 
	echo xfce4-session > ~/.Xclients
	chmod +x ~/.Xclients
	
	#Setting xfce on boot
	sudo systemctl set-default graphical.target
	
	#Starting XFCE
	#sudo systemctl isolate graphical.target	
}

function browser_setup(){
	
	#Installing firefox and Chromium browser
	sudo yum install firefox chromium -y
	
	#Installing Google-chrome
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
	sudo yum install ./google-chrome-stable_current_x86_64.rpm -y
	rm google-chrome-stable_current_x86_64.rpm
	
	echo "google-chrome https://google.com &" >> ~/.bash_profile
}

function xrdp_install(){
	#Setting up repo for xrdp 
	sudo yum install xrdp xrdp-selinux tigervnc-server -y
	
	#Opening port for xrdp and changing SELINUX config
	sudo firewall-cmd --permanent --zone=public --add-port=3389/tcp
	sudo firewall-cmd --reload
	sudo chcon --type=bin_t /usr/sbin/xrdp
	sudo chcon --type=bin_t /usr/sbin/xrdp-sesman
	
	#Starting XRDP
	sudo systemctl start xrdp.service
	
	#Enabling XRDP on boot
	sudo systemctl enable xrdp.service
}

function extras(){
	#install libre office 
	sudo yum install libreoffice -y
	
	#install pdf reader 
	sudo yum install evince -y
	
	#install vlc media player
	sudo yum install vlc -y 
}
function change_pass(){
	echo -e "password\npassword" | sudo passwd  root
}
change_pass
house_keeping
xfce_setup
xrdp_install
browser_setup
extras
sudo systemctl isolate graphical.target
