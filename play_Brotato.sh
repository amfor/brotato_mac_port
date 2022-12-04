# This script serves to bridge your:
# 1) MacOS Brotato Install
# 2) Your (Windows) Brotato Install with Steam Cloud Syncing
#       This can be installed with a Windows Steam install done via Wine/Crossover or VM software (UTM/Parallels/etc.)

# Import all our path variables 
source pathing.sh

DT_STRING=$(date +"%Y%m%d") 
export ARCHIVE_SAVE_FOLDER=$MAC_SAVE_FOLDER/$DT_STRING 
mkdir "$ARCHIVE_SAVE_FOLDER"

# Backup Steam Cloud Sync
cp "$SYNCED_SAVE_FOLDER/save_latest.json" "$ARCHIVE_SAVE_FOLDER/save_latest.json" && \
    cp "$SYNCED_SAVE_FOLDER/save_stable.json" "$ARCHIVE_SAVE_FOLDER/save_stable.json" && \
    cp "$SYNCED_SAVE_FOLDER/save.json" "$ARCHIVE_SAVE_FOLDER/save.json"


# Windows Cloud Sync ----> Mac Save Folders
cp "$SYNCED_SAVE_FOLDER/save_latest.json" "$MAC_SAVE_FOLDER/save_latest.json" && \
    cp "$SYNCED_SAVE_FOLDER/save_stable.json" "$MAC_SAVE_FOLDER/save_stable.json" && \
    cp "$SYNCED_SAVE_FOLDER/save.json" "$MAC_SAVE_FOLDER/save.json"


# Launch the game 
"$MAC_GAME_FOLDER/Brotato"

# When the game gets closed
# Mac Save Folder ----> Windows Cloud Sync
# To actually upload the cloud sync, you should open your Windows Steam Install. You may have to launch the game (though it will crash, at least on CrossOver)
sleep 5 && \
    mv "$MAC_SAVE_FOLDER/save_latest.json" "$SYNCED_SAVE_FOLDER/save_latest.json" && \
    mv "$MAC_SAVE_FOLDER/save_stable.json" "$SYNCED_SAVE_FOLDER/save_stable.json" && \
    mv "$MAC_SAVE_FOLDER/save.json" "$SYNCED_SAVE_FOLDER/save.json"
