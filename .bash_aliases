alias openapp="pkill java;npm start -- --resetCache"
alias killnode="pkill node"
alias yt="firefox https://www.youtube.com/results?search_query="
alias ytp="firefox -private-window https://www.youtube.com/results?search_query="
alias mut="pacmd suspend 1"
alias res="pacmd suspend 0"
alias sleep="systemctl suspend"
alias die="poweroff"
alias insdep="npm install --legacy-peer-deps"
alias createNspaceApk="cd ~/Desktop/Workspace/nspace-mobile-fe/ && react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/ && cd android && ./gradlew assembleDebug && pkill java && cd app/build/outputs/apk/debug/"
alias flipper="~/Desktop/flipper/flipper & disown"
alias creaternapk="(react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/ && cd android && ./gradlew :app:assembleDebug -PreactNativeArchitectures=x86,x86_64 && pkill java)"
alias updatealias="nano ~/.bash_aliases"
alias runon="(cd ~/Desktop/Workspace/nspace-mobile-fe/ && npx react-native run-android --list-devices)"
alias fixmetadriver="~/Desktop/temp/fixmetadriver"
alias ngrok="/home/user/Desktop/ngrok"
alias sharenspaceapk="ngrok http file:///home/user/Desktop/Workspace/nspace-mobile-fe/android/app/build/outputs/apk/debug"
alias openseparateapp="react-native run-android --active-arch-only"
alias checkbattery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
alias openfiles='xdg-open "${*:-.}"'
alias killprocesses=kill_processes
alias pexists='pgrep -f "$1" > /dev/null && echo "not found" || echo "found"'
alias killjava="pkill java"
alias killemulator="pkill qemu-system-x86"
alias opennspace="(cd ~/Desktop/Workspace/nspace-mobile-fe/ && openapp)"
alias opennspacefolder="cd ~/Desktop/Workspace/nspace-mobile-fe/"
alias wifi="sudo service NetworkManager "
alias sudo="sudo "
alias studio="/opt/android-studio/bin/studio.sh && disown"
alias python="python3"
alias py="python"
alias runonmydevice="npx react-native run-android --deviceId 4a0d8c9a0321 --no-jetifier"
# alias phpstorm="/opt/Php*/bin/phpstorm.sh && disown" # installed phpstorm through snap
alias apt="sudo apt"

open_folder(){
    local t="xdg-open ${*}"
}

yt_search() {
    local x="https://www.youtube.com/results?search_query=${*}"
    firefox $x
}

ytp_search() {
    local x="https://www.youtube.com/results?search_query=${*}"
    firefox -private-window $x
}

kill_processes(){
    # Check if the script is executed with a process name argument
    # if [ $# -eq 0 ]; then
    #     echo "Usage: $0 <process_name>"
    #     exit 1
    # fi

    process_names=("java" "node" "flipper")

    # Loop over each process name
    for name in "${process_names[@]}"; do
        # Use the 'pkill' command to end processes with the specified name
        pkill -f "$name"

        # Check if processes were successfully killed
        if [ $? -eq 0 ]; then
            echo "Processes named '$name' were successfully stopped."
        else
            echo "No processes found with the name '$name'."
        fi
    done
}

alias yt='yt_search'

fd() { # Define a function to find files and list files containing a keyword
    local search_method="${1}"
    local pattern="$2"
    local directory="${3:-.}"

    case "$search_method" in
        0)
            find "$directory" -maxdepth 1 -type f -name "*$pattern*"
            ;;
        1)
            find "$directory" -type f | grep -E "$pattern"
            ;;
        *)
            echo "Use '0' for ls or '1' for find.\nfd [0 || 1] [file] [path]"
            return 1
            ;;
    esac
}


sourcehotspot() {
	mysql -u root -p -e 'source /home/user/Downloads/hotspot_schema_2024-02-22.sql'
}

droptriggers() {
    mysql -u root -p hotspot_testing -e "
        SELECT CONCAT('DROP TRIGGER ', trigger_name, ';') AS drop_trigger_statement FROM information_schema.triggers WHERE trigger_schema = 'hotspot_testing';
    "
}
