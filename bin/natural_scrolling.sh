#!/bin/sh

# Support a natural scrolling in Ubintu

DEV_NO=`xinput list | grep "ETPS/2 Elantech Touchpad" | sed 's/.*id=\([0-9]*\).*/\1/g'`
PROP_NO=`xinput list-props $DEV_NO | grep "Synaptics Scrolling Distance" | sed 's/.*(\([0-9]*\)).*/\1/g'`

xinput set-prop $DEV_NO $PROP_NO -65 -65
nautilus -q
nautilus -n &
