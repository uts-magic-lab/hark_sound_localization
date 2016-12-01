#!/bin/sh

TF=`rospack find hark_turtlebot_fdnetworks`/networks/TF/microcone_rectf.zip
DEVICE=plughw:1,0

echo ""
echo "Location of your TF file : $TF"
echo ""
echo "ALSA Audio Device ID : $DEVICE"
echo ""

rosrun hark_turtlebot_fdnetworks localization_ROS_microcone.n ${TF} ${DEVICE}
