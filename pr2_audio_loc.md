# PR2 audio source localization

From [this instructions](http://www.hark.jp/wiki.cgi?page=HARK-ROS-TURTLEBOT+Installation+Instructions).

Adding to `/etc/apt/sources.list.d/hark.list`:

```
deb http://winnie.kuis.kyoto-u.ac.jp/HARK/harkrepos precise non-free
deb-src http://winnie.kuis.kyoto-u.ac.jp/HARK/harkrepos precise non-free
```

## Install necessary components

```bash
sudo apt-get install harkfd
sudo apt-get install hark-ros-hydro
```

## Compile sound loc demo for turtlebot

Get the source from [here](http://www.hark.jp/src/1.2.0/hark-ros-turtlebot-stack-1.2.0.tar.gz).


Extract `hark_sound_source_localization` in a new workspace:

```bash
mkdir ~/sound_loc_ws
cd ~/sound_loc_ws
mkdir src
cd src
cp YOURPATH/hark_sound_source_localization .
```

You'll need to compile the package with rosmake:

```bash
export ROS_PACKAGE_PATH=~/sound_loc_ws/src:$ROS_PACKAGE_PATH
rosmake hark_sound_source_localization
```

## Setup your Kinect audio card

Open `nodes/localization_ROS.sh` and change to your needs:

```bash
#DEVICE=plughw:1,0
DEVICE=plughw:0,0
```

## Run the source localization magic

If you try to run it now (`./localization_ROS.sh`) it will say something like:

```
Location of your TF file : /home/demoshare/sam_stuff/sound_loc_ws/src/hark_sound_source_localization/networks/TF/kinect_final.dat

ALSA Audio Device ID : plughw:0,0

UINodeRepository::Scan()
Scanning def /usr/lib/flowdesigner/toolbox
done loading def files
loading XML document from memory
node_RosNodeGenerator_1 : param NODE_NAME no longer used
node_LocalizeMUSIC_1 : param ELEVATION no longer used
node_RosHarkMsgsPublisher_1 : param ADVANCE no longer used
node_RosHarkMsgsPublisher_1 : param ENABLE_DEBUG no longer used
node_RosHarkMsgsPublisher_1 : param TOPIC_NAME_HARKWAVE no longer used
node_RosHarkMsgsPublisher_1 : param TOPIC_NAME_HARKFFT no longer used
node_RosHarkMsgsPublisher_1 : param TOPIC_NAME_HARKFEATURE no longer used
node_RosHarkMsgsPublisher_1 : param TOPIC_NAME_HARKSOURCE no longer used
node_RosHarkMsgsPublisher_1 : param TOPIC_NAME_HARKSRCWAVE no longer used
node_RosHarkMsgsPublisher_1 : param TOPIC_NAME_HARKSRCFFT no longer used
node_RosHarkMsgsPublisher_1 : param TOPIC_NAME_HARKSRCFEATURE no longer used
node_RosHarkMsgsPublisher_1 : param TOPIC_NAME_HARKSRCFEATUREMFM no longer used
node_RosHarkMsgsPublisher_1 : param BUFFER_NUM no longer used
node_RosHarkMsgsPublisher_1 : param ROS_LOOP_RATE no longer used
node_RosHarkMsgsPublisher_1 : param TIMESTAMP_TYPE no longer used
node_RosHarkMsgsPublisher_1 : param SAMPLING_RATE no longer used
node_RosHarkMsgsPublisher_1 : param ROS_FRAME_ID no longer used
done!
Building network  :MAIN
reading A matrix
[E] [zip_open failed:
    From HARK2.1 that uses libharkio3,
    the format of a transfer function has been changed.
    You can convert the transfer function using 'harktoolcli-conv-tf',
    which is a command line interface of harktool5.
] [harkio_TransferFunction_fromFile] [160]
Segmentation fault

```

So thanks to [this link](http://www.hark.jp/wiki.cgi?page=libharkio3+FAQ) we know we need to do:

```bash
sudo apt-get install harktool5
```

And

```bash
cd networks/TF
harktoolcli-conv-tf -l kinect_final.dat -s kinect_final.tff -o kinect_final.zip
```

And now change `localization_ROS.sh` to have:

```
TF=`rospack find hark_sound_source_localization`/networks/TF/kinect_final.zip
```

Note it's `.zip` now and not `.dat`.

Executing again we get:

```
UINode.cc line 221: Node not found: RosHarkMsgsPublisher
```

Apparently we REALLY need to do:

    sudo apt-get install hark-ros-hydro

Which installs all this in our PR2:

```
fltk1.3-doc fluid gazebo hark-ros-hydro libart-2.0-2 libcegui-mk2-0.7.5 libcegui-mk2-dev libdevil-dev libdevil1c2 libfltk-forms1.3 libfltk-images1.3 libfltk1.1-dev libfltk1.3 libgeos-3.2.2
  libgeos-c1 libgnomecanvas2-0 libgnomecanvas2-common libgsl0ldbl liblodo3.0 liblua5.1-0 liblua5.1-0-dev libmng-dev libois-1.3.0 libopencv-core2.3 libopencv-highgui2.3 libopencv-imgproc2.3
  libplayerc++3.0 libplayerc3.0 libplayercommon3.0 libplayercore3.0 libplayerdrivers3.0 libplayerinterface3.0 libplayerjpeg3.0 libplayertcp3.0 libplayerwkb3.0 libpmap3.0 libsilly libstatgrab6
  libxerces-c3.1 python-epydoc python-kitchen python-opengl python-qt4-gl robot-player ros-hydro-actionlib-tutorials ros-hydro-common-tutorials ros-hydro-desktop ros-hydro-desktop-full
  ros-hydro-gazebo-msgs ros-hydro-gazebo-plugins ros-hydro-gazebo-ros ros-hydro-gazebo-ros-pkgs ros-hydro-geometry-tutorials ros-hydro-interactive-marker-tutorials ros-hydro-librviz-tutorial
  ros-hydro-nodelet-tutorial-math ros-hydro-pluginlib-tutorials ros-hydro-qt-gui-app ros-hydro-qt-gui-core ros-hydro-ros-full ros-hydro-ros-tutorials ros-hydro-roscpp-tutorials
  ros-hydro-rosdoc-lite ros-hydro-rospy-tutorials ros-hydro-rqt-moveit ros-hydro-rqt-nav-view ros-hydro-rqt-pose-view ros-hydro-rqt-robot-dashboard ros-hydro-rqt-robot-monitor
  ros-hydro-rqt-robot-plugins ros-hydro-rqt-robot-steering ros-hydro-rqt-runtime-monitor ros-hydro-rqt-rviz ros-hydro-rqt-tf-tree ros-hydro-rviz-plugin-tutorials ros-hydro-rviz-python-tutorial
  ros-hydro-simulators ros-hydro-stage ros-hydro-stage-ros ros-hydro-turtle-actionlib ros-hydro-turtle-tf ros-hydro-turtle-tf2 ros-hydro-urdf-tutorial ros-hydro-visualization-marker-tutorials
  ros-hydro-visualization-tutorials ros-hydro-viz sdformat texlive-fonts-recommended texlive-fonts-recommended-doc tipa
```

To run the node, it opens a GUI, you need to do

```
ssh -X demoshare@pr2
and run the command
```


```
sudo apt-get install ros-hydro-jsk-hark-msgs
```