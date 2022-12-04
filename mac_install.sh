export APP_ID=1942280 # Brotato Steam App ID

# This script is spun off from instruction from the community thread
# https://steamcommunity.com/app/1942280/discussions/search/?gidforum=3266809256837679849&include_deleted=1&q=Chance+for+Mac
# Caveat: This method does not sync your save files. You will have a fresh save on boot.

source pathing.sh

echo "Enter your Steam Username"
read STEAM_USERNAME

# Install SteamCMD
mkdir ~/Steam && cd ~/Steam
curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_osx.tar.gz" | tar zxvf -
# Install Brotato (Windows Version) using SteamCMD
# This is the only way to install windows games on MacOS w/o a VM or Wine+Steam.
./steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir $MAC_GAME_FOLDER +login $STEAM_USERNAME +app_update $APP_ID validate +exit

mkdir godot_files && cd godot_files
# Download Latest Release (g351 at time of writing)
# See https://github.com/Gramps/GodotSteam/releases for latest release
curl -L -O https://github.com/Gramps/GodotSteam/releases/download/g351-s155-gs3183/godotsteam-351-templates.zip
unzip godotsteam-351-templates.zip
unzip macos.zip

# Copy godot_osx_release.64 and libsteam_api.dylib into Brotato folder
cd ~/Steam
cp godot_files/osx_template.app/Contents/MacOS/godot_osx_release.64 $MAC_GAME_FOLDER/Brotato
cp godot_files/osx_template.app/Contents/MacOS/libsteam_api.dylib $MAC_GAME_FOLDER/libsteam_api.dylib

# Create a save archive in case anything gets corrupted.
mkdir $MAC_GAME_FOLDER/save_archive

# Run the game once to generate the save folder/files
# Close the game after 10s

timeout -s SIGKILL 10 .$MAC_GAME_FOLDER/Brotato
