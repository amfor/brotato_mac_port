Consists of three scripts:

* mac_install.sh
* play_Brotato.sh
* pathing.sh

One issues is that your game won't be able to sync to the Steam Cloud... unless:

## Workaround for Steam Cloud Save Syncing:
 
1. Install [CrossOver](https://www.codeweavers.com/crossover)
2. Use it to Install Steam
3. Use the Steam Bottle to install Brotato (This will fetch your cloud saves)

In my case, the save files are found in this directory:
> "/Users/$USER/Library/Application Support/CrossOver/Bottles/Steam/drive_c/users/crossover/AppData/Roaming/Brotato/76561198017744487"

You can presumably do this with [UTM](https://mac.getutm.app/), [Parallels](https://www.parallels.com/), etc. 
If you use a different method, you'll need to modify the `SYNCED_SAVE_FOLDER` within `pathing.sh`

# Instructions 

## Clone the repo & make the scripts executable
```bash
git clone git@github.com:amfor/brotato_mac_port.git
chmod +x mac_install.sh && chmod +x play_Brotato.sh && chmod +x pathing.sh
```

## Install the Game using SteammCMD ([Homebrew](https://brew.sh/) must be installed)
```bash
./mac_install.sh 
```


## Play the Game
```bash
./play_Brotato.sh 
```

### On Game Launch
* Steam Cloud Save -- copied --> Archive Folder (Located @ Local Mac Save/SAVE_DATE)
* Steam Cloud Save -- copied --> Local Mac Save



### On Game Exit
* Local Mac Save -- copied --> Windows Steam Save

### After Launching Windows Steam Install
* Windows Steam Save --> Steam Cloud Save


#### M1 Support! 
I managed to compile a working arm64 template, which is named Brotato.arm64. 
Simply move it into the game folder and rename it to Brotato, and you will have better performance with ~20-30% energy savings.

