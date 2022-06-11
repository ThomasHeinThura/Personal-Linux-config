
The Projects is mainly focus to reuse linux config when linux has installed. 

![This is an image](https://github.com/ThomasHeinThura/Personal-Linux-config/blob/master/screenshot/DeepinScreenshot_select-area_20220608215230.png)

![This is an image](https://github.com/ThomasHeinThura/Personal-Linux-config/blob/master/screenshot/DeepinScreenshot_select-area_20220608215318.png)

# Distrobution - Arcolinux already yay.aur has already installed , also arcolinux mirror include.
## Apps I use

*Windows manager* &nbsp;	-> awesome (config file inclued), rofi (for prompt run use> <dmenu theme is favourite)  
*Txt Editor*&nbsp; &nbsp; &nbsp; -> vim , nano (command line) emacs (GUI) (doom.d config file include)  
*IDE* 				-> pycharm_community_ediiton , octave , Android Studio  
*Browser*	     		-> Firebox or Opera  
*Player*  			-> vlc player  
*File manager*			-> nemo and its extentions(archive, termianl inside fm) , pcmanfm (GuI) , ranger (command line)  
*Termainal* 			-> alacritty (termianl emulator)(config include) , fish (config include) -> dependency = starship , exa   
*Graphic Desgin*		-> Blender   
	
Network			     	- Networkmanager and samba
	
fancontrol			- nvfancontrol for nvidia gpu , lmsensor (arch wiki //simplily// sensordetech, sensors, pwconfig)
	
Backup				- timeshift (can only install when yay is avalible)
	
audio				- pluse audio , alsa-utils
	
fiel share and donwload          - tansmission-qt
	
chat 				- telegram
	
screenshot and photo view	- deepin-screenshot and deepin-image-viewer
	
sensors data checking		- htop (cpu only), nvtop (gpu only) , gotop (cpu+gpu) (cli) , conky (GUI)(config file include)
	
login manager			- Lightdm or ssdm (ssdm-candy is fav for now)
	
customize linux			- nvidia driver (to activate nvfancontrol "/etc/x11/xorg.connf.d/30.nvidia.conf" need to modify) 
			        - nitrogen (for wallpaper), picom (for background transparent)(config include)
		     		- neofetch or archey4 (install with yay)
	

## For machine learning and Deep Learning
Linux is good choice for ml and dl because of its ease to install cuda and driver.
For now, Arch and its distros can be down so easliy to install nvidia driver, cuda and other. <test file include>

Installation of nvidia driver, cuda, cudnn, tensorflow-cuda, python-cuda, python-tensorflow-cuda with just one line. 
	[$sudo pacman -S  <things to install>] 
	
		sudo pacman -S nvidia cuda cudnn tensorflow-cuda python-cuda python-tensorflow-cuda python-pip
	
Make sure you have numpy and matplotlib. check with pip list.
		
		pip list

If there is no matplotlib and numpy, install with pip instsall numpy and matplotlib. 
After that you can locate with cd command and run
	
		python tensor_test.py

When doing side to side comparsion to windows, performance is nearly similar but the utlization of gpu is much higher is windows <nearly 100%> and take 10GB of GPU memory. Meanwhile Linux <archo linux> take 30-40% gpu utilization with 10GB of GPU memory.

To backup the pacman package
		
		sudo pacman -Qqe > my_package.txt 
or
		
		sudo pacman -Q > my_package.txt

to install backup package
	
		sudo pacman -S - < my_package.txt
