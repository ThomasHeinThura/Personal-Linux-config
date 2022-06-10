
The Projects is mainly focus to back and reused of linux config when linux has installed

Distrobution - Arcolinux already yay.aur has already installed , also arcolinux mirror include.
Apps I use
windows manager 			- awesome <config file inclued>, rofi <for prompt run use> <dmenu theme is favourite>
Txt Editor				- vim , nano <command line> emacs <GUI> <doom.d config file include>
IDE 					- pycharm , clion , octave , Android Studio
Browser		     		- Firebox or Opera
Player 	     			- vlc player
File manager			- nemo and its extentions<archive, termianl inside fm> , pcmanfm <GuI> , ranger <command line>
Termainal 				- alacritty <termianl emulator><config include> , fish <config include> -> dependency = starship , exa 
Graphic Desgin			- Blender 
Network			     	- Networkmanager and samba
fancontrol				- nvfancontrol for nvidia gpu , lmsensor <arch wiki> //simplily <sensordetech, sensors, pwconfig>
Backup				- timeshift <can only install when yay is avalible>
audio					- pluse audio , alsa-utils
fiel share and donwload 	- tansmission-qt
chat 					- telegram
screenshot and photo view	- deepin-screenshot and deepin-image-viewer
sensors data checking		- htop<cpu only>, nvtop<gpu only> , gotop < cpu+gpu> <cli> , conky <GUI><config file include>
login manager			- Lightdm or ssdm <ssdm-candy is fav for now>
customize linux			- nvidia driver <to activate nvfancontrol "/etc/x11/xorg.connf.d/30.nvidia.conf" need to modify> 
				     	- nitrogen <for wallpaper>, picom < for background transparent > <config include>
			     		- neofetch or archey4 <install with yay>

For machine learning and Deep Learning
Linux is good choice for ml and dl because of its ease to install cuda and driver.
For now, Arch and its distros can be down so easliy to install nvidia driver, cuda and other. <test file include>

Installation of nvidia driver, cuda, cudnn, tensorflow-cuda, python-cuda, python-tensorflow-cuda with just one line. [$sudo pacman -S  <things to install>] 
After that you can run test file. [$python tensor_test.py]

When doing side to side comparsion to windows, performance is nearly similar but the utlization of gpu is much higher is windows <nearly 100%> and take 10GB of GPU memory. Meanwhile Linux <archo linux> take 30-40% gpu utilization with 10GB of GPU memory.

