
### The Project mainly focus to reuse linux config when linux has installed. 

Project include multiple config files that I search online and re-config for my own personal tastes. These files are from Dt(youtuber), Titus Linux(youtuber) and others from Github and I combine and reconfig them. If you use, I encourage you to re-configure the file according to your tastes and your systems.  
**You don't necessary need to download all of my files. Just download the config what you need and reconfig it. If you download the config with git clone, I recommend you to move to ~/.config folder.**

### Login ( sddm-sugar-candy )
![This is an image of login](https://github.com/ThomasHeinThura/Personal-Linux-config/blob/master/screenshot/DeepinScreenshot_select-area_20220611121434.png)
### Screen 1 (neofetch, ranger, vim and conky)
![This is an image of Scrren 1](https://github.com/ThomasHeinThura/Personal-Linux-config/blob/master/screenshot/DeepinScreenshot_select-area_20220608215230.png)
### Screen 2 (unimatrix -s 90)
![This is an image of Screen 2](https://github.com/ThomasHeinThura/Personal-Linux-config/blob/master/screenshot/DeepinScreenshot_select-area_20220608215318.png)

# Distrobution - Arcolinux with yay.aur and arcolinux mirror include.
## Apps I use (include arcolinux_package.txt so you can check what packages are installed)
**Windows manager** &nbsp;	- awesome (config file inclued), rofi (for prompt run use) (dmenu theme is favourite)  
**Txt Editor** 			- vim , nano (command line) emacs (GUI) (doom.d config file include)  
**IDE** 			- pycharm_community_ediiton , clion ,  octave , Android Studio  
**Browser**	     		- Firebox or Opera or Brave  
**Player**  			- vlc player  
**File manager**		- nemo and its extentions(archive, termianl inside fm) , pcmanfm (Gui) , ranger (command line)  
**Termainal** 			- alacritty (termianl emulator)(config include) , fish (config include) -> dependency = starship , exa   
**Graphic Desgin**		- Blender   
**Network**		     	- Networkmanager and samba  
**fancontrol**			- nvfancontrol for nvidia gpu , lmsensor for other fan.(arch wiki //simply// sensordetech, sensors, pwconfig)  
**Backup**			- timeshift (can only install when yay is avalible)  
**Audio**			- pluse audio , alsa-utils   
**File share and donwload**     - tansmission-qt     
**Chat** 			- telegram    
**ScreenLayerout**		- arandr  
**Screenshot and photo view**	- deepin-screenshot and deepin-image-viewer   
**Sensors data checking**	- htop (cpu only), nvtop (nvidia gpu only) , gotop (cpu+gpu) (cli) , conky (GUI)(config file include)  
**login manager**		- Lightdm or sddm (ssdm-candy is fav for now) // sddm-config-editor software is nice to have because it can configure with GUI  
**Customize linux**		- nvidia driver (to activate nvfancontrol "/etc/x11/xorg.connf.d/30.nvidia.conf" need to modify)   
			        - nitrogen (for wallpaper), picom (for background transparent)(config include)   
		     		- neofetch or archey4 (install with yay), unimatrix.  
				
### Notes:
- Most of awesome windows manager shortcuts are commented out because I think it is un-necessary and too many shortcuts to remember. If you want them uncomment them out. 
- If you use multi-screen like me, Use arandr to save .sh file. Then, add in sddm configure setting if you use sddm. For others ways, searching in google can get more answers.
- I use vim txt editor. But you can find many other GUI out there.
- you will find etc folder in my project. This is for nvfancontrol. In some case nvfancontrol need to add some config file. Then add 30.nvidia.conf to /etc/X11/xorg.conf.d/ and Xwarrper.conf to /etc/X11/. In multi-monitor and multi-gpu case, I recommend to add 10.monitor.conf and modesetting.conf file to /etc/X11/xorg.conf.d/. Then add nvfancontrol.conf in ~/.config/. This will use nvidia-gpu fan according to Tempeature. Other files in /etc/X11/ are not need for your config. For more knowledge search in arch wiki about intel gpu, xorg, xinitrc, nvidia gpu.
- For other fan controlling, lmsensor software is used. This is from arch wiki fancontrol(https://wiki.archlinux.org/title/fan_speed_control). I simply run in these commenad in terminal and manually config.
## For machine learning and Deep Learning
Linux is good choice for ml and dl because of its ease to install cuda and driver.
For now, Arch and its distros can be download requirements and so easliy to install nvidia driver, cuda and other. (test file include)

Installation of nvidia driver, cuda, cudnn, tensorflow-cuda, python-cuda, python-tensorflow-cuda with just one line. [ $sudo pacman -S  (things to install) ] 
	
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
