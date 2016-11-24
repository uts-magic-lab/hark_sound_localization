#!/bin/sh

TF=`rospack find hark_turtlebot_fdnetworks`/networks/TF/kinect_final.zip
DEVICE=plug:mixin

echo ""
echo "Location of your TF file : $TF"
echo ""
echo "ALSA Audio Device ID : $DEVICE"
echo ""

rosrun hark_turtlebot_fdnetworks localization_ROS.n ${TF} ${DEVICE}
