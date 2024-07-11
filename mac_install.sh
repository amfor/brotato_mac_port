export APP_ID=1942280 # Brotato Steam App ID

source pathing.sh

# Install Brotato (Windows Version) using SteamCMD
# This is the only way to install windows games on MacOS w/o a VM or Wine+Steam.

echo "Enter your Steam Username"
read STEAM_USERNAME

echo "Enter your Steam Password"
read STEAM_PASSWORD

echo "Enter your SteamGuard Code"
read STEAM_CODE


./steamcmd.sh +@sSteamCmdForcePlatformType windows +force_install_dir $MAC_GAME_FOLDER +login $STEAM_USERNAME $STEAM_PASSWORD $STEAM_CODE +app_update $APP_ID validate +exit

mkdir godot_files && cd godot_files
# Download Latest Release (g353 at time of writing)
# See https://github.com/Gramps/GodotSteam/releases for latest release
curl -L -O https://github.com/GodotSteam/GodotSteam/releases/download/v3.26/godotsteam-g353-s160-gs326-templates.zip
unzip godotsteam-g353-s160-gs326-templates.zip
unzip macos.zip

# Copy godot_osx_release.64 and libsteam_api.dylib into Brotato folder
cd ~/Steam
cp ./osx_template.app/Contents/MacOS/godot_osx_release.64 $MAC_GAME_FOLDER/Brotato
cp ./osx_template.app/Contents/MacOS/libsteam_api.dylib $MAC_GAME_FOLDER/libsteam_api.dylib

# Create a save archive in case anything gets corrupted.
mkdir $MAC_GAME_FOLDER/save_archive

# Run the game once to generate the save folder/files
# Close the game after 10s

timeout -s SIGKILL 10 $MAC_GAME_FOLDER/Brotato
