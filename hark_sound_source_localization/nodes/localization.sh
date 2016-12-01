#!/bin/sh

TF=`rospack find hark_sound_source_localization`/networks/TF/kinect_final.dat
#DEVICE=plughw:1,0
DEVICE=plughw:0,0

echo ""
echo "Location of your TF file : $TF"
echo ""
echo "ALSA Audio Device ID : $DEVICE"
echo ""

rosrun hark_sound_source_localization localization.n ${TF} ${DEVICE}
