; SAMPLEPLAY (2011) for realtime Csound5 - by Arthur B. Hunkins
; Requires MIDI device with up to 25 keys, buttons or pads
;   optionally, keys/button/pads velocity sensitive
;   optionally, 1 additional key/button/pad and/or 1-4 MIDI knobs or sliders
; 0-1 background loop, 1-25 single-shot samples.
;  Files may be mono or stereo; can have different sample rates, may be a variety of
;   uncompressed types including WAV and AIFF; also Ogg/Vorbis (with Sugar 0.86/
;   Blueberry or later, or Sugar 0.84/Strawberry with updated libsndfile) but not MP3.
;  Background loop must be named soundin.0, and samples labeled soundin.1 and up.
;  They must be placed in the same folder as this file or they may be loaded
;   through the Journal (with Sugar 0.84/Strawberry or later).

<CsoundSynthesizer>
<CsOptions>

-odac -+rtaudio=alsa -+rtmidi=alsa -M hw:1,0 -m0d --expression-opt -b128 -B2048 -+raw_controller_mode=1

</CsOptions>
<CsInstruments>

sr      = 44100
; change sample rate to 48000 (or 32000 if necessary) when 44100 gives no audio.
; (Necessary for Intel Classmate PC and some other systems.)
ksmps   = 100
nchnls  = 2

        seed    0
        massign 0, 0
ga1     init    0
ga2     init    0

gichan    chnexport "Chan", 1
gibackgnd chnexport "Backgnd", 1
gibgmax   chnexport "Bgmax", 1
gistctrl  chnexport "Stctrl", 1
gistnote  chnexport "Stnote", 1
gistfade  chnexport "Stfade", 1
gisamps   chnexport "Samps", 1
gisampamp chnexport "Sampamp", 1
gisampmax chnexport "Sampmax", 1
gismpctrl chnexport "Smpctrl", 1
gimidi1   chnexport "MIDI1", 1
gireplace chnexport "Replace", 1
gismpfreq chnexport "Smpfreq", 1
gifrqctrl chnexport "Frqctrl", 1
gipanpos  chnexport "Panpos", 1
gipanctrl chnexport "Panctrl", 1
gifilter  chnexport "Filter", 1
gicutoff  chnexport "Cutoff", 1

	instr 1

gkfreq  init   0
gkpan   init   .5
kflag   init   0
isampmax =     gisampmax * .1
        if ((gibackgnd == 0) || (kflag == 1)) goto skip
        event  "i", 2, 0, -1
kflag   =      1
skip:
gkstat,gkchan,gkd1,gkd2 midiin
        if ((gkstat == 0) || (gkchan != gichan)) goto end               
        if ((gkstat != 144) && (gkstat != 128)) goto end               
        if ((gireplace != 2) && ((gkstat == 128) || ((gkstat == 144) && (gkd2 == 0)))) goto end
	if ((gkd1 < gimidi1) || (gkd1 > (gimidi1 + (gisamps - 1)))) goto end       
ksamp   =      gkd1 - gimidi1 + 1
kinstr  =      ksamp + 2
        if gisampamp > 0 goto skip2
kamp    =      1
        goto skip3
skip2:
        if gisampamp > 1 goto skip4
kamp    random .1, 1
        goto skip3
skip4:                                
        if gisampamp > 2 goto skip5                                                                    
kamp    =      gkd2 / 127
        goto skip3
skip5:        
kamp    ctrl7  gichan, gismpctrl, 0, 1
skip3:
        if gismpfreq == 0 goto skip6
        if gismpfreq > 1 goto skip7       
gkfreq  trirand .05
        goto skip6
skip7:
        if gismpfreq > 2 goto skip8
gkfreq  =      ((gkd2 / 64) - 1) * .05
        goto skip6        
skip8:
gkfreq  ctrl7  gichan, gifrqctrl, -.05, .05        
skip6:
        if gipanpos = 0 goto skip9
        if gipanpos > 1 goto skip10       
gkpan   linrand 1
        goto skip9
skip10:
        if gipanpos > 2 goto skip11
gkpan   =      gkd2 / 127
        goto skip9        
skip11:
gkpan   ctrl7   gichan, gipanctrl, 0, 1
skip9:
        if gireplace > 0 goto skip12
        goto skip13
skip14:
ilen    filelen i(ksamp)
        rireturn
skip13:        
        reinit skip14
        event  "i", kinstr, 0, ilen, kamp * isampmax, gkfreq, gkpan
        goto end
skip12:
        if (((gkstat == 144) && (gkd2 == 0)) || (gkstat == 128)) goto skip15
        event  "i", kinstr, 0, -1, kamp * isampmax, gkfreq, gkpan
        goto end
skip15:
        event  "i", -kinstr, 0, 1
                
end:    endin

        instr 2

kamp    init   0
ibgmax  =      gibgmax * .1
Sname   chnget  "file0"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont
Sname   =       "soundin.0"
cont:
ichans  filenchnls Sname
        if gibackgnd == 2 goto skip
        if ((gkstat == 144) && (gkd1 == gistnote) && (gkd2 > 0)) goto skip2
        goto skip3        
skip2:        
kamp    =      (kamp == 0? ibgmax: 0)
skip3:
kamp2   lineto kamp, gistfade
kamp2	=      (kamp2 < .01? 0: kamp2)
        goto skip4
skip:        
kamp2	ctrl7  gichan, gistctrl, 0, ibgmax
skip4:
        if ichans == 2 goto skip5
aout    diskin2 Sname, 1, 0, 1
ga1     =       aout * kamp2
ga2     =       aout * kamp2
        goto end
skip5:
a1, a2  diskin2 Sname, 1, 0, 1
ga1     =       a1 * kamp2
ga2     =       a2 * kamp2

end:    endin

        instr 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27

        if p1 != 3 goto cont              
Sname   chnget  "file1"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.1"
        goto cont2
cont:
        if p1 != 4 goto cont3              
Sname   chnget  "file2"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.2"
        goto cont2
cont3:
        if p1 != 5 goto cont4              
Sname   chnget  "file3"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.3"
        goto cont2
cont4:
        if p1 != 6 goto cont5              
Sname   chnget  "file4"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.4"
        goto cont2
cont5:
        if p1 != 7 goto cont6              
Sname   chnget  "file5"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.5"
        goto cont2
cont6:
        if p1 != 8 goto cont7              
Sname   chnget  "file6"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.6"
        goto cont2
cont7:
        if p1 != 9 goto cont8              
Sname   chnget  "file7"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.7"
        goto cont2
cont8:
        if p1 != 10 goto cont9              
Sname   chnget  "file8"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.8"
        goto cont2
cont9:
        if p1 != 11 goto cont10              
Sname   chnget  "file9"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.9"
        goto cont2
cont10:
        if p1 != 12 goto cont11              
Sname   chnget  "file10"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.10"
        goto cont2
cont11:
        if p1 != 13 goto cont12              
Sname   chnget  "file11"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.11"
        goto cont2
cont12:
        if p1 != 14 goto cont13              
Sname   chnget  "file12"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.12"
        goto cont2
cont13:
        if p1 != 15 goto cont14              
Sname   chnget  "file13"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.13"
        goto cont2
cont14:
        if p1 != 16 goto cont15              
Sname   chnget  "file14"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.14"
        goto cont2
cont15:
        if p1 != 17 goto cont16              
Sname   chnget  "file15"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.15"
        goto cont2
cont16:
        if p1 != 18 goto cont17              
Sname   chnget  "file16"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.16"
        goto cont2
cont17:
        if p1 != 19 goto cont18              
Sname   chnget  "file17"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.17"
        goto cont2
cont18:
        if p1 != 20 goto cont19              
Sname   chnget  "file18"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.18"
        goto cont2
cont19:
        if p1 != 21 goto cont20              
Sname   chnget  "file19"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.19"
        goto cont2
cont20:
        if p1 != 22 goto cont21              
Sname   chnget  "file20"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.20"
        goto cont2
cont21:
        if p1 != 23 goto cont22              
Sname   chnget  "file21"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.21"
        goto cont2
cont22:
        if p1 != 24 goto cont23              
Sname   chnget  "file22"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.22"
        goto cont2
cont23:
        if p1 != 25 goto cont24              
Sname   chnget  "file23"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.23"
        goto cont2
cont24:
        if p1 != 26 goto cont25              
Sname   chnget  "file24"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.24"
        goto cont2
cont25:
Sname   chnget  "file25"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.25"
cont2:
ichans  filenchnls Sname
ilen    filelen Sname
        if gireplace == 2 goto skip
kamp    linseg  0, .025, p4, ilen - .35, p4, .325, 0
        goto skip2
skip:
kamp    linsegr  0, .025, p4, ilen - .35, p4, .325, 0
skip2:        
        if ichans == 2 goto skip3
aout    diskin2 Sname, 1 + p5, 0, 0
a1,a2,a3,a4 pan aout, p6, 1, 1, 1
ga1     =       ga1 + (a1 * kamp)
ga2     =       ga2 + (a2 * kamp)
        goto skip4
skip3:
aout,aout2 diskin2 Sname, 1 + p5, 0, 0
a1,a2,a3,a4 pan aout, p6, 1, 1, 1
a5,a6,a7,a8 pan aout2, p6, 1, 1, 1
ga1     =       ga1 + ((a1 + a5) * kamp)
ga2     =       ga2 + ((a2 + a6) * kamp)
skip4:    
ktime   timeinsts
        if ((gireplace < 2) || (ktime < (ilen - .2))) goto end
        turnoff

end:    endin
   
        instr 100

        if gifilter == 0 goto skip
a1      atonex   ga1, gicutoff
a2      atonex   ga2, gicutoff
        outs    a1, a2           
        goto skip2
skip:
        outs    ga1, ga2           
skip2:
ga1     =       0
ga2     =       0

end:    endin

</CsInstruments>

<CsScore>

f1 0 8193 9 .25 1 0
i1 0 3600
i100 0 3600

e

</CsScore>
</CsoundSynthesizer> 
