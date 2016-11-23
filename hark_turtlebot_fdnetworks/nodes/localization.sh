#!/bin/sh

TF=`rospack find hark_turtlebot_fdnetworks`/networks/TF/kinect_final.dat
#DEVICE=plughw:1,0
DEVICE=plughw:0,0

echo ""
echo "Location of your TF file : $TF"
echo ""
echo "ALSA Audio Device ID : $DEVICE"
echo ""

rosrun hark_turtlebot_fdnetworks localization.n ${TF} ${DEVICE}
