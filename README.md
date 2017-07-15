# CentOS7 

The Script performs the following tasks : 
- house_keeping
- xfce_setup
- xrdp_install
- browser_setup
- extras

Elobrate description about the above tasks:
1) house_keeping :
	a) Updates the system 
	b) Installs misc tools 
	c) Installs repos for package installation 
	
2) xfce_setup : 
	a) Installs X Windows System
	b) Installs XFCE desktop environment
	c) Set files for XRDP
	d) Set XFCE onboot

3) xrdp_install :
	a) Installs xrdp and tigervnc
	b) Configures firewall and SELINUX for xrdp
	c) Starts xrdp service 
	d) Set xrdp onboot

4) browser_setup :
	a) Installs firefox,google-chrome-stable,chromium
	b) Set Chrome browser to spwan every time the user connects to the machine 
	
5) extras : 
	a) Installs Libreoffice
	b) Installs PDF reader 
	c) Installs VLC media player
