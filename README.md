# hark sound localization

Based on the hark tools for sound localization and the demo for the turtlebot.

Instructions on how this was brought back to life can be found in [pr2_audio_loc.md](pr2_audio_loc.md), they are more related to Ubuntu 12.04.

Instructions on how to install the dependencies can be found at the start of [new_microphone.md](new_microphone.md).

This has been tested on:

* Ubuntu 12.04 64b on PR2 with a Kinect (old one) (ROS Hydro). [Watch it working](https://www.youtube.com/watch?v=B7THEridi7A).
* Ubuntu 14.04 64b with PSeye (ROS Indigo).
* Ubuntu 14.04 64b with microcone (ROS Indigo).

# Run it

For the PR2 Kinect, you'll need to enable the Kinect as an audio device first, follow [this instructions](pr2_kinect_audio.md). Then you can just run:

```bash
roslaunch hark_sound_source_localization pr2_kinect.launch
```

You'll find the topic `/hark_source` of type `hark_msgs/HarkSource` reporting where the audio comes from at 120Hz~ with messages looking like:

```
header: 
  seq: 7049
  stamp: 
    secs: 1480557477
    nsecs: 563368941
  frame_id: HarkRosFrameID
count: 7049
exist_src_num: 1
src: 
  - 
    id: 15
    power: 38.3558311462
    x: 0.615999996662
    y: 0.73400002718
    z: 0.287000000477
    azimuth: 49.9953804016
    elevation: 16.67345047
```

The **power** field relates to the volume of the heard noise and the **azimuth** represents the angle where 
the audio came from.

For the PSeye launch:

```
roslaunch hark_sound_source_localization pseye.launch 
```

For the microcone launch:

```
roslaunch hark_sound_source_localization microcone.launch
```

# Change parameters

If you need to change the device used you need to edit the file [localization_ROS_pseye.sh](hark_sound_source_localization/nodes/localization_ROS_pseye.sh).

Change the line `DEVICE=plughw:1,0` to whatever suits you. You may use `arecord -L` to help find your device. If you need more than one device accesing at the microphone at the same time you can follow [these instructions](https://gist.github.com/awesomebytes/924493bcdb358f5e71fdff93c2896730#to-let-more-than-one-software-access-to-the-microphone).


If you want to change the minimum power threshold on when localization (and tracking) happens you'll need to edit [localization_ROS_pseye.n](hark_sound_source_localization/networks/localization_ROS_pseye.n), modify this line:

```
      <Parameter name="THRESH" type="float" value="35" description="Power threshold for localization results. A localization result with higher power than THRESH is tracked, otherwise ignored."/>
```

To change the range of the angle where localization occurs (both the kinect and the pseye have been 
trained their transfer functions for 360 degrees) modify the lines:

```
      <Parameter name="MIN_DEG" type="int" value="-90" description="Minimum source direction to localize in degree. [default: -180]"/>
      <Parameter name="MAX_DEG" type="int" value="90" description="Maximum source direction to localize in degree. [default: 180]"/>
```

I don't recommend it tho.

# I have another microphone, and I want to localize audio source with it!

First check if it supported in [HARK supported hardware](http://www.hark.jp/wiki.cgi?page=SupportedHardware) list, as of writing this, they support:

* TAMAGO-01
* RASP-24
* RASP-LC
* Kinect
* Xbox One Kinect (Kinect v2)
* PlayStation Eye
* Microcone
* Kurage-kun

Well... if you have different hardware and you want to
use it for this same purpose then you'll need to create a transfer function for it.

[Video tutorial](https://www.youtube.com/watch?v=9v5RUOrkyhw) of what this is about.

[Video tutorial](https://www.youtube.com/watch?v=_Tpn94mPtj4) of using harktool4 to generate the files.

Then use `harktoolcli-conv-tf` as `harktoolcli-conv-tf -l loc_tf.dat -s sep_tf.dat -o transfer.zip`.

You may find some extra notes I wrote [in new_microphone.md](new_microphone.md).

