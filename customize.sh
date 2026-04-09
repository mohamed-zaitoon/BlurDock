#!/system/bin/sh

MODPATH=${0%/*}

ui_print() { echo "$1"; }
abort() { echo "$1"; exit 1; }

ui_print "Installing BlurDock Module"
ui_print "Developed by: Mohamed Zaitoon"
ui_print ""

# -----------------------------
# Xiaomi devices only
MANUFACTURER=$(getprop ro.product.manufacturer | tr '[:upper:]' '[:lower:]')
echo "$MANUFACTURER" | grep -q "xiaomi" || abort "This module supports Xiaomi devices only!"

# -----------------------------
# Android 15+ (SDK 35+)
ANDROID_SDK=$(getprop ro.build.version.sdk)
[ -n "$ANDROID_SDK" ] || abort "Failed to detect Android version!"
[ "$ANDROID_SDK" -ge 35 ] || abort "Requires Android 15 or higher!"

# -----------------------------
# HyperOS 2+
HYPER_CODE=$(getprop ro.mi.os.version.code)
HYPER_NAME=$(getprop ro.mi.os.version.name)

if [ -n "$HYPER_CODE" ]; then
  [ "$HYPER_CODE" -ge 2 ] || abort "Requires HyperOS 2 or higher!"
elif [ -n "$HYPER_NAME" ]; then
  echo "$HYPER_NAME" | grep -Eq "^[2-9]" || abort "Requires HyperOS 2 or higher!"
else
  abort "HyperOS not detected!"
fi

# -----------------------------
# Start service.sh in background
/system/bin/sh $MODPATH/service.sh &

ui_print ""
ui_print "BlurDock installed successfully on your Xiaomi device."
exit 0