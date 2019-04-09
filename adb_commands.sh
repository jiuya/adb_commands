#!/bin/bash
adb connect $1

while IFS= read -r -n1 -s char; do
    if [[ $char == $'\x1b' ]]; then
      read -r -n2 -s rest
      char+="$rest"
    fi
    case "$char" in
    q ) break ;;
    s ) adb shell am start -a android.settings.APPLICATION_SETTINGS ;;
    H ) adb shell am start -a android.settings.HOME_SETTINGS ;;
    $'\x0a'|e ) adb shell input keyevent ENTER ;;
    b ) adb shell input keyevent BACK ;;
    B ) adb shell input keyevent HOME ;;
    k|$'\x1b\x5b\x41' ) adb shell input keyevent DPAD_UP ;;
    j|$'\x1b\x5b\x42' ) adb shell input keyevent DPAD_DOWN ;;
    l|$'\x1b\x5b\x43' ) adb shell input keyevent DPAD_RIGHT ;;
    h|$'\x1b\x5b\x44' ) adb shell input keyevent DPAD_LEFT ;;
    esac
done

adb disconnect
