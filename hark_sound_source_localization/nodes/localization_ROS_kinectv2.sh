#!/bin/sh

TF=`rospack find hark_sound_source_localization`/networks/TF/kinectv2_rectf.zip
DEVICE=plug:mixin

echo ""
echo "Location of your TF file : $TF"
echo ""
echo "ALSA Audio Device ID : $DEVICE"
echo ""

rosrun hark_sound_source_localization localization_ROS.n ${TF} ${DEVICE}
