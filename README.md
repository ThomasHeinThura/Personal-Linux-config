
### The Project mainly focus to reuse linux config when linux has installed. 

The Project includes multiple config files that I search online and re-config for my own personal tastes. These files are from Dt(YouTuber), Titus Linux(YouTuber) and others from GitHub and I combine and re-config them. If you use, I encourage you to re-configure the file according to your tastes and your systems.  
**You don't necessary need to download all of my files. Just download the config what you need and re-config it. If you download the config with git clone, I recommend you to move to `~/.config` folder.**

### Login ( sddm-sugar-candy )
![This is an image of login](https://github.com/ThomasHeinThura/Personal-Linux-config/blob/master/screenshot/DeepinScreenshot_select-area_20220611121434.png)
### Screen 1 (neofetch, ranger, vim and conky)
![This is an image of Screen 1](https://github.com/ThomasHeinThura/Personal-Linux-config/blob/master/screenshot/DeepinScreenshot_select-area_20220608215230.png)
### Screen 2 (unimatrix -s 90)
![This is an image of Screen 2](https://github.com/ThomasHeinThura/Personal-Linux-config/blob/master/screenshot/DeepinScreenshot_select-area_20220608215318.png)

# Distro - Arcolinux with yay.aur and arcolinux mirror include.
## Apps I use (include arcolinux_package.txt, so you can check what I install)
**Windows manager** &nbsp;	- awesome (config file included), rofi (for prompt run use) (d menu theme is favourite)  
**Txt Editor** 			- vim , nano (command line) emacs (GUI) (doom.d config file include)  
**IDE** 			- pycharm_community_ediiton ,  octave , Android Studio  
**Browser**	     		- Firebox or Opera or Brave  
**Player**  			- vlc player  
**File manager**		- nemo and its extensions(archive, terminal inside fm) , pcmanfm (Gui) , ranger (command line)  
**Terminal** 			- alacritty (terminal emulator)(config include) , fish (config include) -> dependency = starship , exa   
**Graphic Design**		- blender   
**Network**		     	- networkmanager and samba  
**fancontrol**			- nvfancontrol for nvidia gpu , lm_sensor for other fan.( command : sensors-detect, sensors, pwmconfig )  
**Backup**			- timeshift (can only install when yay is available)  
**Audio**			- pulse audio , alsa-utils   
**File share and download**     - tansmission-qt     
**Chat** 			- telegram    
**Screen Layerout**		- arandr  
**Screenshot and photo view**	- deepin-screenshot and deepin-image-viewer   
**Sensors data checking**	- htop (cpu only), nvtop (nvidia gpu only) , gotop (cpu+gpu) (cli) , conky (GUI)(config file include)  
**login manager**		- Lightdm or sddm (sddm-candy is fav for now) // sddm-config-editor software is nice to have because it can configure with GUI  
**Other Packages**		- nvidia driver , nitrogen (for wallpaper), picom (for background transparent)(config include) , neofetch or archey4 (install with yay), unimatrix.  
				
### Notes:
- Most of `awesome` windows manager shortcuts are commented out because I think it is un-necessary and too many shortcuts to remember. If you want them uncomment them out.   
- If you use multi-screen like me, Use `arandr` to save `.sh` file. Then, add in sddm configure setting if you use `sddm`. For other ways, searching in Google can get more answers.  
- I use vim txt editor. But you can find many other GUI out there.  
- You will find etc folder in my project. This is for `nvfancontrol`. In some case `nvfancontrol` need to add some config file. Then add `30.nvidia.conf` to `"/etc/X11/xorg.conf.d/"` and `Xwarrper.conf` to `"/etc/X11/"`. In multi-monitor and multi-gpu case, I recommend adding `10.monitor.conf` and `modesetting.conf` file to `"/etc/X11/xorg.conf.d/."` Then add `nvfancontrol.conf` in `"~/.config/"`. This will use nvidia-gpu fan according to Temperature. Other files in etc/X11/ are not need for your config. For more knowledge, search in arch wiki about intel gpu, xorg, xinitrc, nvidia gpu.  

- For other fan controlling, `lm_sensors` software is used. This is from arch wiki fan speed control (https://wiki.archlinux.org/title/fan_speed_control). I simply run these commend(`sensors-detect`, `sensors`, `pwmconfig`) line by line in terminal and manually config.  
**When run `sensors-detect`, some need `sudo`. It is OK to comfirm "yes" in detecting stage. In `sensors` command, just find how many fans are in there. In `pwmconfig` stage, I recommend you configure manually according to numbers of fans you have. To configure manually, you need to remember what fan names are and just config after the scan.**(Config file is in /etc/fancontorl.conf) // I don't get any luck in trying with fancontrol-gui software.
- **Backup is IMPORTANT!!!** I use **timeshift** software to backup the system.  
 
**Conky**
- I reconfigure conky config file. Main nvidia gpu statuses are exported.(you need to install nvidia and nividia-settings package.) I use gpu to train ML and DL data, so these statuses are necessary for me. If you don't want them, then comment them out.  
- Network card also need to reconfigure according to your card. `ip addr` command can find your network name starting with `enp`. Disk drives can also search with `sudo fdisk -l` command, and add `/dev/sd*` to config You can add many disks you want. I also command out single core cpu useage.  

## For machine learning and Deep Learning
Linux is good choice for ml and dl because of its ease to install cuda and driver.  
For now, Arch and its distros can be download requirements(nvidia driver, cuda and other) so easily. (test file include)  

Installation of nvidia driver, cuda, cudnn, tensorflow-cuda, python-cuda, python-tensorflow-cuda and python-pip with just one line. [`$sudo pacman -S` (things to install)] 
	
		sudo pacman -S nvidia cuda cudnn tensorflow-cuda python-cuda python-tensorflow-cuda python-pip
	
Make sure you have numpy and matplotlib. Check with `pip list`.
		
		pip list

If there is no matplotlib and numpy, install with `pip instsall` numpy and matplotlib. 
After that, you can locate with `cd` command and run
	
		python tensor_test.py

When doing side to side comparison to windows, performance is nearly similar but the utilization of gpu is much higher in windows (nearly 100%) and take 10GB of GPU memory. Meanwhile, Linux (arcolinux) take 30-40% gpu utilization with 10GB of GPU memory.

### Pacman backup and reinstall 
To backup the pacman package
		
		sudo pacman -Qqe > my_package.txt 
or
		
		sudo pacman -Q > my_package.txt

to install backup package
	
		sudo pacman -S - < my_package.txt
