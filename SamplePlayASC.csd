; SAMPLEPLAYASC (2011) for realtime Csound5 - by Arthur B. Hunkins
; SamplePlayASC.csd - ASCII keyboard only (no MIDI)
;  0-1 background loop, 1-25 single-shot samples. Mono or stereo, any sample rate.
;  May be a variety of uncompressed types including WAV and AIFF;
;   also Ogg/Vorbis (with Sugar 0.86/Blueberry or later, or Sugar 0.84/Strawberry
;   with updated libsndfile) but not MP3. Background loop must be named soundin.0,
;   and samples labeled soundin.1 and up.
;  They must be placed in the same folder as this file or they may be loaded
;   through the Journal (with Sugar 0.84/Strawberry or later).
; Note: in Sugar version, ` key triggers background loop.

<CsoundSynthesizer>
<CsOptions>

-odac -+rtaudio=alsa -m0d --expression-opt -b128 -B2048

</CsOptions>
<CsInstruments>

sr      = 44100
; change sample rate to 48000 (or 32000 if necessary) when 44100 gives no audio.
; (Necessary for Intel Classmate PC and some other systems.)
ksmps   = 100
nchnls  = 2

        seed    0
ga1     init    0
ga2     init    0
gkold	init    0

gibackgnd chnexport "Backgnd", 1
gibgmax   chnexport "Bgmax", 1
gistfade  chnexport "Stfade", 1
gisamps   chnexport "Samps", 1
gisampamp chnexport "Sampamp", 1
gisampmax chnexport "Sampmax", 1
gireplace chnexport "Replace", 1
gismpfreq chnexport "Smpfreq", 1
gipanpos  chnexport "Panpos", 1
gifilter  chnexport "Filter", 1
gicutoff  chnexport "Cutoff", 1
gkasc     chnexport "ascii", 1

	instr 1

kflag   init   0
gkamp   init   1
gkfreq  init   0
gkpan   init   .5
kamp    init   gisampamp
kfreq   init   gismpfreq
kpan    init   gipanpos
isampmax =     gisampmax * .1

        if ((gibackgnd == 0) || (kflag == 1)) goto skip
        event  "i", 2, 0, -1
kflag   =      1
        kgoto end
skip:
	if ((gkasc == gkold) || (gkasc == 96)) goto end
gkold	=      gkasc
	if gkold == 0 goto end
        if kamp == 0 goto skip2
        if kamp > 1 goto skip3
gkamp   random .1, 1
        kgoto skip2 
skip3:
        if ((gkasc < 48) || (gkasc > 57)) goto skip2
gkamp   =     (gkasc - 48) * .1
gkamp   =     (gkasc == 48? gkamp + 1: gkamp)
        kgoto end
skip2:        
        if kfreq == 0 goto skip4
        if kfreq > 1 goto skip5
gkfreq  trirand .05
        kgoto skip4
skip5:                                      
        if gkasc != 33 goto skip6
gkfreq  =       -.05
        kgoto end
skip6:
        if gkasc != 64 goto skip7
gkfreq  =       -.043
        kgoto end
skip7:        
        if gkasc != 35 goto skip8
gkfreq  =       -.035
        kgoto end
skip8:
        if gkasc != 36 goto skip9
gkfreq  =       -.026
        kgoto end
skip9:
        if gkasc != 37 goto skip10
gkfreq  =       -.016
        kgoto end
skip10:
        if gkasc != 94 goto skip11
gkfreq  =       -.005
        kgoto end
skip11:
        if gkasc != 38 goto skip12
gkfreq  =      .007
        kgoto end
skip12:
        if gkasc != 42 goto skip13
gkfreq  =      .02
        kgoto end
skip13:
        if gkasc != 40 goto skip14
gkfreq  =      .034
        kgoto end
skip14:
        if gkasc != 41 goto skip4
gkfreq  =      .05
        kgoto end
skip4:
        if kpan == 0 goto skip15
        if kpan > 1 goto skip16
gkpan   linrand 1
        kgoto skip15
skip16:                                      
        if gkasc != 122 goto skip17
gkpan   =      0
        kgoto end
skip17:        
        if gkasc != 120 goto skip18
gkpan   =      .1111
        kgoto end
skip18:        
        if gkasc != 99 goto skip19
gkpan   =      .2222
        kgoto end
skip19:        
        if gkasc != 118 goto skip20
gkpan   =      .3333
        kgoto end
skip20:        
        if gkasc != 98 goto skip21
gkpan   =      .4444
        kgoto end
skip21:        
        if gkasc != 110 goto skip22
gkpan   =      .5555
        kgoto end
skip22:        
        if gkasc != 109 goto skip23
gkpan   =      .6666
        kgoto end
skip23:        
        if gkasc != 44 goto skip24
gkpan   =      .7777
        kgoto end
skip24:        
        if gkasc != 46 goto skip25
gkpan   =      .8888
        kgoto end
skip25:        
        if gkasc != 47 goto skip15
gkpan   =      1
        kgoto end
skip15:
        if gkasc != 113 goto skip26
ksamp   =       1
        kgoto skip27
skip26:
        if gisamps < 2 kgoto end
        if gkasc != 119 goto skip28
ksamp   =       2
        kgoto skip27
skip28:
        if gisamps < 3 kgoto end
        if gkasc != 101 goto skip29
ksamp   =       3
        kgoto skip27
skip29:
        if gisamps < 4 kgoto end
        if gkasc != 114 goto skip30
ksamp   =       4
        kgoto skip27
skip30:
        if gisamps < 5 kgoto end
        if gkasc != 116 goto skip31
ksamp   =       5
        kgoto skip27
skip31:
        if gisamps < 6 kgoto end
        if gkasc != 121 goto skip32
ksamp   =       6
        kgoto skip27
skip32:
        if gisamps < 7 kgoto end
        if gkasc != 117 goto skip33
ksamp   =       7
        kgoto skip27
skip33:
        if gisamps < 8 kgoto end
        if gkasc != 105 goto skip34
ksamp   =       8
        kgoto skip27
skip34:
        if gisamps < 9 kgoto end
        if gkasc != 111 goto skip35
ksamp   =       9
        kgoto skip27
skip35:
        if gisamps < 10 kgoto end
        if gkasc != 112 goto skip36
ksamp   =       10
        kgoto skip27
skip36:
        if gisamps < 11 kgoto end
        if gkasc != 91 goto skip37
ksamp   =       11
        kgoto skip27
skip37:
        if gisamps < 12 kgoto end
        if gkasc != 93 goto skip38
ksamp   =       12
        kgoto skip27
skip38:
        if gisamps < 13 kgoto end
        if gkasc != 97 goto skip39
ksamp   =       13
        kgoto skip27
skip39:
        if gisamps < 14 kgoto end
        if gkasc != 115 goto skip40
ksamp   =       14
        kgoto skip27
skip40:
        if gisamps < 15 kgoto end
        if gkasc != 100 goto skip41
ksamp   =       15
        kgoto skip27
skip41:
        if gisamps < 16 kgoto end
        if gkasc != 102 goto skip42
ksamp   =       16
        kgoto skip27
skip42:
        if gisamps < 17 kgoto end
        if gkasc != 103 goto skip43
ksamp   =       17
        kgoto skip27
skip43:
        if gisamps < 18 kgoto end
        if gkasc != 104 goto skip44
ksamp   =       18
        kgoto skip27
skip44:
        if gisamps < 19 kgoto end
        if gkasc != 106 goto skip45
ksamp   =       19
        kgoto skip27
skip45:
        if gisamps < 20 kgoto end
        if gkasc != 107 goto skip46
ksamp   =       20
        kgoto skip27
skip46:
        if gisamps < 21 kgoto end
        if gkasc != 108 goto skip47
ksamp   =       21
        kgoto skip27
skip47:
        if gisamps < 22 kgoto end 
        if gkasc != 59 goto skip48
ksamp   =       22
        kgoto skip27
skip48:
        if gisamps < 23 kgoto end 
        if gkasc != 39 goto skip49
ksamp   =       23
        kgoto skip27
skip49:
        if gisamps < 24 kgoto end 
        if gkasc != 45 goto skip50
ksamp   =       24
        kgoto skip27
skip50:
        if gisamps < 25 kgoto end 
        if gkasc != 61 goto end 
ksamp   =       25
skip27:
        if gireplace == 1 goto skip51
        event  "i", ksamp + 2, 0, .01, gkamp * isampmax, gkfreq, gkpan
        kgoto end
skip51:
        event  "i", ksamp + 2, 0, -1, gkamp * isampmax, gkfreq, gkpan
                
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
	if gkasc != 96 goto skip
	if gkasc == gkold goto skip
gkold	=       gkasc
; in Sugar version, ` triggers background loop
kamp    =       (kamp == 0? ibgmax: 0)
skip:
kamp2   lineto kamp, gistfade
kamp2   =       (kamp2 < .01? 0: kamp2)
        if ichans == 2 goto skip2
aout    diskin2 Sname, 1, 0, 1
ga1     =       aout * kamp2
ga2     =       aout * kamp2
        goto end
skip2:
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
	if gireplace == 1 goto skip
	xtratim ilen - .01
skip:
kamp    linseg  0, .025, p4, ilen - .35, p4, .325, 0
        if ichans == 2 goto skip2
aout    diskin2 Sname, 1 + p5, 0, 0
a1,a2,a3,a4 pan aout, p6, 1, 1, 1
ga1     =       ga1 + (a1 * kamp)
ga2     =       ga2 + (a2 * kamp)
        goto end
skip2:
aout,aout2 diskin2 Sname, 1 + p5, 0, 0
a1,a2,a3,a4 pan aout, p6, 1, 1, 1
a5,a6,a7,a8 pan aout2, p6, 1, 1, 1
ga1     =       ga1 + ((a1 + a5) * kamp)
ga2     =       ga2 + ((a2 + a6) * kamp)
        
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
