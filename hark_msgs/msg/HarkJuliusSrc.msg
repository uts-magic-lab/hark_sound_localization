int32 id
float32 azimuth
float32 elevation
int32 sec
int32 usec
int32 frames
int32 msec
int8 status            # status of recognition process defined below
HarkJuliusSrcVal[] src # WHYPO results for each source

int8 TERMINATED=0
int8 STARTRECOG=1
int8 INPUTPARAM=2
int8 SOURCEINFO=3
int8 RECOGOUT=4
int8 RECOGFAIL=5
