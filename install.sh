#!/bin/bash

useColor="true"

function Color () { #https://habr.com/ru/companies/first/articles/672464/

    local foreground=$1
    local background=$2

    if [ "$foreground" == "" ];  then foreground="Default"; fi
    if [ "$background" == "" ]; then background="$color_background"; fi

    local colorString='\033['

    case "$foreground" in
        "Default")      colorString='\033[0;39m';;
        "Black" )       colorString='\033[0;30m';;
        "DarkRed" )     colorString='\033[0;31m';;
        "DarkGreen" )   colorString='\033[0;32m';;
        "DarkYellow" )  colorString='\033[0;33m';;
        "DarkBlue" )    colorString='\033[0;34m';;
        "DarkMagenta" ) colorString='\033[0;35m';;
        "DarkCyan" )    colorString='\033[0;36m';;
        "Gray" )        colorString='\033[0;37m';;
        "DarkGray" )    colorString='\033[1;90m';;
        "Red" )         colorString='\033[1;91m';;
        "Green" )       colorString='\033[1;92m';;
        "Yellow" )      colorString='\033[1;93m';;
        "Blue" )        colorString='\033[1;94m';;
        "Magenta" )     colorString='\033[1;95m';;
        "Cyan" )        colorString='\033[1;96m';;
        "White" )       colorString='\033[1;97m';;
        *)              colorString='\033[0;39m';;
    esac

    case "$background" in
        "Default" )     colorString="${colorString}\033[49m";;
        "Black" )       colorString="${colorString}\033[40m";;
        "DarkRed" )     colorString="${colorString}\033[41m";;
        "DarkGreen" )   colorString="${colorString}\033[42m";;
        "DarkYellow" )  colorString="${colorString}\033[43m";;
        "DarkBlue" )    colorString="${colorString}\033[44m";;
        "DarkMagenta" ) colorString="${colorString}\033[45m";;
        "DarkCyan" )    colorString="${colorString}\033[46m";;
        "Gray" )        colorString="${colorString}\033[47m";;
        "DarkGray" )    colorString="${colorString}\033[100m";;
        "Red" )         colorString="${colorString}\033[101m";;
        "Green" )       colorString="${colorString}\033[102m";;
        "Yellow" )      colorString="${colorString}\033[103m";;
        "Blue" )        colorString="${colorString}\033[104m";;
        "Magenta" )     colorString="${colorString}\033[105m";;
        "Cyan" )        colorString="${colorString}\033[106m";;
        "White" )       colorString="${colorString}\033[107m";;
        *)              colorString="${colorString}\033[49m";;
    esac

    echo "${colorString}"
}

function WriteLine () {

    local resetColor='\033[0m'

    local str=$1
    local forecolor=$2
    local backcolor=$3

    if [ "$str" == "" ]; then
        printf "\n"
        return;
    fi

    if [ "$useColor" == "true" ]; then
        local colorString=$(Color ${forecolor} ${backcolor})
        printf "${colorString}%s${resetColor}\n" "${str}"
    else
        printf "%s\n" "${str}"
    fi
}

function Write () {
    local resetColor="\033[0m"

    local forecolor=$1
    local backcolor=$2
    local str=$3

    if [ "$str" == "" ];  then
        return;
    fi

    if [ "$useColor" == "true" ]; then
        local colorString=$(Color ${forecolor} ${backcolor})
        printf "${colorString}%s${resetColor}" "${str}"
    else
        printf "%s" "$str"
    fi
}

function start_termux11() {
    export DISPLAY=:1 && kill -9 $(pgrep -f "termux.x11") 2>/dev/null; if command -v openbox-session >/dev/null 2>&1; then termux-x11 -ac -xstartup openbox-session :1 2>/dev/null; else termux-x11 -ac :1; fi &
    
    WriteLine "Succefull!" "Green"
    
    menu
}

gamepath="/storage/emulated/0/Download/Xbox/flat2.iso"
function iso_path() {
    WriteLine "Current game path: $gamepath" "Cyan"
    WriteLine "  1. Edit path"
    WriteLine "  2. Cancel"
    read j
    
    case "$j" in
    1)
      read -e -p "Current: " -i "$gamepath" gamepath
    ;;
    *)
        menu
    ;;
    esac
    
    WriteLine "Selected path: $gamepath" "Green"
    
    sleep 0.5
    
    menu
}

function drivers() {
    WriteLine "WIP" "Red"
}

function start_xemu() {
    WriteLine "xemu -dvd_path $gamepath" "White"
    
    WriteLine "XEMU STARTED!" "Yellow"
    
    sleep 0.5
    
    menu
}

function menu () {
  Write "clear"
  WriteLine "Select a option: " "Yellow"
  WriteLine "  1. Start Termux11" "DarkMagenta"
  WriteLine "  2. Setup gamepath" "DarkYellow"
  WriteLine "  3. Setup vulkan_driver (only Adreno GPUs)" "DarkRed"
  WriteLine "  4. Start XEMU" "DarkGreen"
  WriteLine "  5. Exit" "White" "DarkRed"
  Write "Selected number: " "DarkGreen"
  read i
  
  case "$i" in
  1)
    start_termux11
  ;;
  2)
    iso_path
  ;;
  3)
    drivers
  ;;
  4)
    start_xemu
  ;;
  5)
    return 1
  ;;
  *)
    menu
  ;;
  esac
}

function main() {
    #packages
    WriteLine "Installing packages..." "Blue"

    WriteLine "Packages installed!" "Green"

    WriteLine "Packages not installed, fixing..." "Red"
    
    menu
    
    WriteLine "------------------------------------------------------------------"
    WriteLine "Original repo: https://github.com/George-Seven/Termux-XEMU" "White"
    WriteLine "Idea: https://github.com/olegos2/mobox/blob/main/install" "Blue"
    WriteLine "Author: @de0ver" "DarkRed"
    WriteLine "------------------------------------------------------------------"
    
    return 1
}

main  #<---- script start