export APP_ID=1942280 # Brotato Steam App ID
export DLC_APP_ID=2868390 # Brotato DLC App ID

source pathing.sh

brew install --cask godot@3
brew install --cask steamcmd

# Install Brotato (Windows Version) using SteamCMD
# This is the only way to install windows games on MacOS w/o a VM or Wine+Steam.

echo "Enter your Steam Username"
read STEAM_USERNAME

echo "Enter your Steam Password"
read STEAM_PASSWORD

echo "Enter your SteamGuard Code"
read STEAM_CODE

CURRENT_DIR=$(pwd)

mkdir -p pcks

steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir $CURRENT_DIR/pcks +login $STEAM_USERNAME $STEAM_PASSWORD $STEAM_CODE +app_update $APP_ID validate +exit

# Download Godot Reverse Engineering Tools
mkdir -p godot_re_files && cd godot_re_files
curl -L -O https://github.com/bruvzg/gdsdecomp/releases/download/v0.8.0-prerelease.5/GDRE_tools-v0.8.0-prerelease.5-macos.zip
unzip GDRE_tools-v0.8.0-prerelease.5-macos.zip

# Reverse Engineer the game and DLC
mkdir -p brotato_recovered brotato_dlc_recovered
./"Godot RE Tools.app/Contents/MacOS/Godot RE Tools" --headless --recover=$CURRENT_DIR/pcks/Brotato.pck --output-dir=brotato_recovered
./"Godot RE Tools.app/Contents/MacOS/Godot RE Tools" --headless --recover=$CURRENT_DIR/pcks/BrotatoAbyssalTerrors.pck --output-dir=brotato_dlc_recovered
cp -rf brotato_dlc_recovered/dlcs brotato_recovered

# Remove references to the Steam from the game files
mv brotato_recovered/singletons/platforms/steam.gd
sed -i -e '7,11d' brotato_recovered/singletons/platforms/platform.gd
sed -i -e 's/\t_platform_impl = LocalPlatform.new()/_platform_impl = LocalPlatform.new()/' brotato_recovered/singletons/platforms/platform.gd
sed -i -e "s/Steam.activateGameOverlayToStore($DLC_APP_ID)/pass/g" brotato_recovered/ui/menus/pages/main_menu.gd 

cp $CURRENT_DIR/export_presets.cfg brotato_recovered/
cd brotato_recovered/

# Install export templates
mkdir -p $GODOT_TEMPLATE_FOLDER
if [ ! -f "$GODOT_TEMPLATE_FOLDER/osx.zip" ]; then 
    curl -L https://github.com/godotengine/godot/releases/download/3.6-stable/Godot_v3.6-stable_export_templates.tpz;
    unzip Godot_v3.6-stable_export_templates.tpz;
    cp templates/osx.zip $GODOT_TEMPLATE_FOLDER/osx.zip
fi

# Rebuild Brotato
godot --export "Mac OSX" $CURRENT_DIR/Brotato.dmg

hdiutil mount $CURRENT_DIR/Brotato.dmg
cp -R /Volumes/Brotato/ $MAC_GAME_FOLDER
hdiutil unmount /Volumes/Brotato

# Create a save archive in case anything gets corrupted.
mkdir -p $MAC_GAME_FOLDER/Brotato.app/save_archive

cd $CURRENT_DIR
