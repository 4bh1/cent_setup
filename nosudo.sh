functionhouse_keeping(){
	#UpdatingSystem
	yumupdate-y
	
	#Settingupepelrepoandbashcompletionjustincase
	yuminstallepel-release-y
	yuminstallbash-completionbash-completion-extrasnet-toolswget-y
	source/etc/profile.d/bash_completion.sh
	
	#InstallingRPMfusion
	yumlocalinstall--nogpgcheckhttps://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpmhttps://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm-y
}

functionxfce_setup(){
	
	#InstallingXwindowssystem
	yumgroupinstall"XWindowSystem"-y
	
	#InstallingandsetingupXFCE
	yum--enablerepo=epelgroupsinstall"Xfce"-y
	echo"exec/usr/bin/xfce4-session">>~/.xinitrc
	
	#ForXRDP
	echoxfce4-session>$UHOME/.Xclients
	chmod+x$UHOME/.Xclients
	
	#Settingxfceonboot
	systemctlset-defaultgraphical.target
	
	#StartingXFCE
	#systemctlisolategraphical.target	
}

functionbrowser_setup(){
	
	#InstallingfirefoxandChromiumbrowser
	yuminstallfirefoxchromium-y
	
	#InstallingGoogle-chrome
	wget-P$UHOMEhttps://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
	yuminstall$UHOME/google-chrome-stable_current_x86_64.rpm-y
	rm$UHOME/google-chrome-stable_current_x86_64.rpm
	
	echo"google-chromehttps://google.com&">>$UHOME/.bash_profile
}

functionxrdp_install(){
	#Settinguprepoforxrdp
	yuminstallxrdpxrdp-selinuxtigervnc-server-y
	
	#OpeningportforxrdpandchangingSELINUXconfig
	firewall-cmd--permanent--zone=public--add-port=3389/tcp
	firewall-cmd--reload
	chcon--type=bin_t/usr/sbin/xrdp
	chcon--type=bin_t/usr/sbin/xrdp-sesman
	
	#StartingXRDP
	systemctlstartxrdp.service
	
	#EnablingXRDPonboot
	systemctlenablexrdp.service
}

functionextras(){
	#installlibreoffice
	yuminstalllibreoffice-y
	
	#installpdfreader
	yuminstallevince-y
	
	#installvlcmediaplayer
	yuminstallvlc-y
}
functionchange_pass(){
	echo-e"password\npassword"|passwdroot
}

UHOME=$(evalecho~$SUDO_USER)

house_keeping
xfce_setup
xrdp_install
browser_setup
extras
systemctlisolategraphical.target
