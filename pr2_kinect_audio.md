# Enable PR2 Kinect audio

## Add hark packages sources

Follow the [installation instructions](http://www.hark.jp/wiki.cgi?page=HARK+Installation+Instructions).

In PR2 (not pr2s machine):

```bash
sudo bash -c 'echo -e "deb http://winnie.kuis.kyoto-u.ac.jp/HARK/harkrepos precise non-free\ndeb-src http://winnie.kuis.kyoto-u.ac.jp/HARK/harkrepos precise non-free" > /etc/apt/sources.list.d/hark.list'
```

```bash
wget -q -O - http://winnie.kuis.kyoto-u.ac.jp/HARK/harkrepos/public.gpg | sudo apt-key add -
```

```bash
sudo apt-get update
```


## Install kinect hark

Follow [the instructions](http://www.hark.jp/wiki.cgi?page=HARK-KINECT+Installation+Instructions+(as+a+USB+recording+device)).


```bash
sudo apt-get install hark-kinect
```

Note that the installation may take a bit long as it will download from
Microsoft `KinectSDK-v1.0-beta2-x86.msi` which is ~20Mb.

**Reboot.**

## To check if it worked

The card should appear listed:

```
cat /proc/asound/cards

0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                     Ensoniq AudioPCI ENS1371 at 0x2080, irq 16
1 [Audio          ]: USB-Audio - Kinect USB Audio
                     Microsoft Kinect USB Audio at usb-0000:02:03.0-1, high speed
...
```

You should be able to record an audio with:

```bash
arecord -D hw:0,0 -f S32_LE -r 16000 -c 4 test.wav
```

The audio format is specified [here](http://www.hark.jp/wiki.cgi?page=HARK-KINECT#p6):

| Name          | Type   | Value  | Explanation                       |
|---------------|--------|--------|-----------------------------------|
| LENGTH        | int    | 512    | Number of samples in one frame    |
| ADVANCE       | int    | 160    | Shift length                      |
| CHANNEL_COUNT | int    | 4      | Number of microphone channels     |
| SAMPLING_RATE | int    | 16000  | Sampling rate of the audio stream |
| DEVICE_TYPE   | string | DS     | Category of the sensors           |
| DEVICE        | string | kinect | Device name                       |

## To remove and cleanup

    sudo apt-get --purge remove hark-kinect

    sudo rm /etc/apt/sources.list.d/hark.list

    sudo apt-get update

## To let more than one software access to the microphone

Create the file `~/.asoundrc` with the contents:

```
pcm.mixin {
    type dsnoop
    ipc_key 5978293 # must be unique for all dmix plugins!!!!
    ipc_key_add_uid yes
    slave {
        pcm "hw:0,0"
        channels 4
        period_size 1024
        buffer_size 4096
        rate 16000
              }
}
```

Now you can record with:

    arecord -D plug:mixin -f S32_LE -r 16000 -c 4 test.wav

And any software that wants to record at the same time needs to use the card
`plug:mixin`.

