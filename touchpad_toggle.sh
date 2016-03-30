#!/bin/sh
enabled=$1;
touchpad_id=$(xinput | grep -i "touchpad" | cut -f2 | cut -d '=' -f2);
mouse_id=$(xinput | grep -i "mouse" | grep -i 'pointer' | cut -f2 | cut -d '=' -f2);
mouse_prop=$(xinput list-props $mouse_id | grep -i "velocity" | cut -f2 | cut -d '(' -f2 | cut -d ')' -f1 );
mouse_tmp= "error";

if $enabled
	then
	xinput set-prop $touchpad_id "Device Enabled" 1 | notify-send -i /usr/local/bin/padlock_closed.png "The touchpad is now enabled." "$(cat /tmp/mouse_name) unplugged"
	rm /tmp/mouse_name
else
	mouse_tmp=$(lsusb | grep Mouse | cut -c  34-$(lsusb | grep Mouse | wc -c))
	echo "$mouse_tmp" > /tmp/mouse_name
	xinput set-prop $touchpad_id "Device Enabled" 0 | notify-send -i /usr/local/bin/padlock_open.png "Disabling the touchpad..." "$mouse_tmp plugged"
fi