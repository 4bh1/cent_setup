function house_keeping(){
	#Updating System
	yum update -y
	
	#Setting up epel repo and bash completion just in case
	yum install epel-release -y
	yum install bash-completion bash-completion-extras net-tools wget -y 
	source /etc/profile.d/bash_completion.sh
	
	#Installing RPM fusion
	yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm -y
}

function xfce_setup(){
	
	#Installing Xwindows system 
	yum groupinstall "X Window System" -y
	
	#Installing and seting up XFCE 
	yum --enablerepo=epel groups install "Xfce" -y 
	echo "exec /usr/bin/xfce4-session" >> $UHOME/.xinitrc
	
	#For XRDP 
	echo xfce4-session > $UHOME/.Xclients
	chmod +x $UHOME/.Xclients
	 
	#Setting xfce on boot
	 systemctl set-default graphical.target
	
	#Starting XFCE
	# systemctl isolate graphical.target	
}

function browser_setup(){
	
	#Installing firefox and Chromium browser
	 yum install firefox chromium -y
	
	#Installing Google-chrome
	wget -P $UHOME https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
	 yum install $UHOME/google-chrome-stable_current_x86_64.rpm -y
	rm $UHOME/google-chrome-stable_current_x86_64.rpm
	
	echo "google-chrome https://google.com &" >> $UHOME/.bash_profile
}

function xrdp_install(){
	#Setting up repo for xrdp 
	 yum install xrdp xrdp-selinux tigervnc-server -y
	
	#Opening port for xrdp and changing SELINUX config
	 firewall-cmd --permanent --zone=public --add-port=3389/tcp
	 firewall-cmd --reload
	 chcon --type=bin_t /usr/sbin/xrdp
	 chcon --type=bin_t /usr/sbin/xrdp-sesman
	
	#Starting XRDP
	 systemctl start xrdp.service
	
	#Enabling XRDP on boot
	 systemctl enable xrdp.service
}

function extras(){
	#install libre office 
	 yum install libreoffice -y
	
	#install pdf reader 
	 yum install evince -y
	
	#install vlc media player
	 yum install vlc -y 
}
function change_pass(){
	echo -e "password\npassword" |  passwd  $SUDO_USER
}

UHOME=$(eval echo ~$SUDO_USER)
change_pass
house_keeping
xfce_setup
xrdp_install
browser_setup
extras
 systemctl isolate graphical.target

