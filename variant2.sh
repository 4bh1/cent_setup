function cent(){
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
	house_keeping
	xfce_setup
	xrdp_install
	browser_setup
	extras
	systemctl isolate graphical.target
	
}
function ubuntu(){
	function xfce(){
		apt update && apt upgrade -y 
		apt install xfce4 xrdp -y
		echo xfce4-session > UHOME	/.xsession
		echo startxfce4 >> /etc/xrdp/startwm.sh
		ufw allow 3389/tcp
		sudo service xrdp restart 
	}
	function browser(){
		apt install firefox chromium-browser -y
		wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
		echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
		apt update 
		apt install google-chrome-stable -y

	}
	xfce
	browser
}

function change_pass(){
	echo -e "password\npassword" |  passwd  $SUDO_USER
}
UHOME=$(eval echo ~$SUDO_USER)
OS=$(cat /etc/os-release)

if echo "$OS" | grep -q "Ubuntu"; then
  echo "Ubuntu Selected";ubuntu;
elif echo "$OS" | grep -q "CentOS-7"; then
  echo "CentOS 7 selected";
else 
  echo "Unsupported";
fi

change_pass
