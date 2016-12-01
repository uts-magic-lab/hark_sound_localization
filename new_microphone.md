# hark_sound_loc

Perform sound source localization using hark and ROS.

# Installation

[Hark installation instructions](http://www.hark.jp/wiki.cgi?page=HARK+Installation+Instructions) are quite nice and support Ubuntu 12.04 (ROS Hydro) and 14.04 (ROS Indigo).

Using ubuntu 14.04 in this repo, reproducing instructions:

Add APT repository:

```bash
     sudo bash -c 'echo -e "deb http://winnie.kuis.kyoto-u.ac.jp/HARK/harkrepos trusty non-free\ndeb-src http://winnie.kuis.kyoto-u.ac.jp/HARK/harkrepos trusty non-free" > /etc/apt/sources.list.d/hark.list'
```

Setup PGP key:

```bash
wget -q -O - http://winnie.kuis.kyoto-u.ac.jp/HARK/harkrepos/public.gpg | sudo apt-key add -
```

Update sources:

```bash
sudo apt-get update
```

Install HARK:

```bash
sudo apt-get install harkfd hark-designer julius-4.2.3-hark-plugin harktool4 harktool5
```

They also recommend installing:

```bash
sudo apt-get install librasp-netapi
```

Install ROS wrappers:

```bash
sudo apt-get install hark-ros-indigo hark-ros-stacks-indigo
```

To check the HARK-ROS installation, run HARK-designer in a new terminal:

```bash
hark_designer
```
(The first time you open it it may install node.js related stuff).

A browser will open, find HARK-ROS modules can be found at:
`Preferences > Packages > hark-ros.def`

# Sound localization

Based on the [Learning sound localization](http://www.hark.jp/document/hark-cookbook-en/subsec-LearningHARK-002.html) tutorial.

Note that if you follow those instructions exactly you'll get:

```
./recog.n MultiSpeech.wav loc_tf.dat sep_tf.dat
...
[E] [zip_open failed:
    From HARK2.1 that uses libharkio3,
    the format of a transfer function has been changed.
    You can convert the transfer function using 'harktoolcli-conv-tf',
    which is a command line interface of harktool5.
```

Which is solved by transforming the files `loc_tf.dat` and `sep_tf.dat` into `transfer.zip` using:

```
harktoolcli-conv-tf -l loc_tf.dat -s sep_tf.dat -o transfer.zip
```

And then you'll need to execute it like:
```
./recog.n MultiSpeech.wav transfer.zip transfer.zip
```

I comment this here mainly for the next one to find the problem can Google for a solution.


# How to generate your own transfer function files

[Video tutorial](https://www.youtube.com/watch?v=9v5RUOrkyhw) of what this is about.

[Video tutorial](https://www.youtube.com/watch?v=_Tpn94mPtj4) of using harktool4 to generate the files.

Then use `harktoolcli-conv-tf` as before.




