# CentOS7 on the GO 

The Script performs the following tasks : 
- house_keeping
- xfce_setup
- xrdp_install
- browser_setup
- extras

Elobrate description about the above tasks:
- house_keeping :
	- Updates the system 
	- Installs misc tools 
	- Installs repos for package installation 
	
- xfce_setup : 
	- Installs X Windows System
	- Installs XFCE desktop environment
	- Set files for XRDP
	- Set XFCE onboot

- xrdp_install :
	- Installs xrdp and tigervnc
	- Configures firewall and SELINUX for xrdp
	- Starts xrdp service 
	- Set xrdp onboot

- browser_setup :
	- Installs firefox,google-chrome-stable,chromium
	- Set Chrome browser to spwan every time the user connects to the machine 
	
- extras : 
	- Installs Libreoffice
	- Installs PDF reader 
	- Installs VLC media player
	
# Note Variant1.sh
> variant1.sh no need to run under root privilages but need to add credentials after the execution. But remember on a slow connection you will need to re-enter the credentials. 

# Note Variant2.sh
> variant2.sh need to be exuected as root
