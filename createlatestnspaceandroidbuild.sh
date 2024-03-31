#!/bin/bash

check_node_modules(){
    directory="node_modules"
    if [ -d "$directory" ]; then
        return 1
    else
        return 0
    fi
}

# Check the exit status of the zenity command
ask_project(){
    zenity --width=400 --question --text="Open Nspace directory :: Choose no if you are trying to build other project?"
    if [ $? -eq 0 ]; then
        printf "${YELLOW}\n>>>\tIn Nspace directory...\n\n${RESET}"
        cd ~/Desktop/Workspace/nspace-mobile-fe/
    fi
}

ask_dep_installation(){
    zenity --width=400 --question --text="Do you want to install dependencies?"
    ok=$(check_node_modules)
    echo $ok
    if [ $? -eq 0 ]; then
        return
    else
        printf "${YELLOW}\n>>>\tInstalling dependencies...\n\n${RESET}"
    fi
    npm install --legacy-peer-deps
}

ask_branch_change(){
    zenity --width=400 --question --text="Open development branch?"
    if [ $? -eq 0 ]; then
        printf "${YELLOW}\n>>>\tGetting latest pull\n\n${RESET}"
        printf "${YELLOW}\n>>>\tcheckout development branch\n\n${RESET}"
        git checkout development
    fi
}

ask_branch_updates(){
    zenity --width=400 --question --text="Do you want to get latest branch updates?"
    if [ $? -eq 0 ]; then
        printf "${YELLOW}\n>>>\tGetting latest updates\n\n${RESET}"
        git pull origin development
    fi
}

ask_create_bundle(){
    zenity --width=400 --question --text="Create index bundle?"
    if [ $? -eq 0 ]; then
        printf "${YELLOW}\n>>>\tPlease dont use other apps until process is done, Nspace apk build process initiating...\n\n${RESET}"
        react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/ 
        printf "${GREEN}\n>>>\tindex.andriod.bundle created...\n\n${RESET}"
    fi
}

ask_create_build(){
    zenity --width=400 --question --text="Create android build?"
    if [ $? -eq 0 ]; then
        cd android
        ./gradlew assembleDebug
        printf "${GREEN}\n>>>\tNspace Build Successful.\n\n${RESET}"
    fi
}

ask_open_folder(){
    zenity --width=400 --question --text="Do you want to open the apk containing folder?"
    if [ $? -eq 0 ]; then
        xdg-open app/build/outputs/apk/debug/
    fi
}

no_choice(){
        ask_project
        ask_dep_installation
        ask_branch_change
        ask_branch_updates
        ask_create_bundle
        ask_create_build
        ask_open_folder
}

# Define ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m' # Reset text color

no_choice

ask_choice(){
    printf "
            1.Install dependencies\n\
            2.Change branch to development\n\
            3.Pull changes\n\
            4.Create index.android.bundle >> Do this before Step 5\n\
            5.Create Apk\n\
            6.Open Apk folder\n"
    read CHOICE

    case $CHOICE in

    1)
        # ask_project
        ask_dep_installation
        ;;

    2)
        ask_branch_change
        ;;

    3)
        ask_branch_updates
        ;;

    4)
        ask_create_bundle
        ;;

    5)
        ask_create_build
        ;;

    6)
        ask_open_folder
        ;;

    *)
    printf "Yehaw"
        ;;
    esac
}
