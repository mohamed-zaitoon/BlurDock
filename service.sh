#!/system/bin/sh

MODPATH=${0%/*}

# Wait for boot completed
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

PACKAGE="com.jungleapps.wallpapers"
MAIN_ACTIVITY="com.jungleapps.wallpapers.MainActivityFragment"

# Launch app once
am start -n $PACKAGE/$MAIN_ACTIVITY

# Keep app alive
while true; do
    PID=$(pidof $PACKAGE)
    if [ -z "$PID" ]; then
        am start -n $PACKAGE/$MAIN_ACTIVITY
    fi
    sleep 30
done