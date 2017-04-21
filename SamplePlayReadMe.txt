SAMPLEPLAY - Sugar Activity/Linux version - Notes
Art Hunkins
abhunkin@uncg.edu
www.arthunkins.com


Working with User Soundfiles/Objects

The SamplePlay utility series includes SamplePlay (requiring a
MIDI controller) and SamplePlayASC (performed on the ASCII keyboard
alone). Both can handle mono or stereo soundfiles, and up to 25
samples and a single background loop. The files can be of any sample
rate and a variety of uncompressed formats including WAV and AIFF;
also Ogg/Vorbis, but not MP3. The Ogg/Vorbis format is only possible
when the Sugar version is later than 0.84; this excludes the original
XO-1 and SoaS (Sugar-on-a-Stick) Strawberry.

*However*, the ogg vorbis format (which is written by later versions
of the Record activity) *can* be used by SoaS (Strawberry) 0.84 if
libsndfile is updated. This can be done while connected to the
internet by issuing the following commands in the Terminal:
  su <Enter>
  yum update libsndfile <Enter>
Neither the XO-1.5, nor XO-1 upgraded to Sugar 0.84 require this mod.

Students are encouraged to create their own soundfiles, especially
to make their own nature soundscapes. (This is the primary intent
behind these utilities. The 25 bird samples and background loop
included here are collectively called OISEAUX ORDINAIRES, in honor of
the French composer Olivier Messiaen, his fascination with nature -
especially unique bird calls, and his work for piano and small
orchestra, Oiseaux Exotiques.)

The natural vehicle for soundfile creation is the Record activity.
This activity is fairly simple and straightforward; the only problem
is that many versions of it do not work with various incarnations of
Sugar. The following pairings of Record with Sugar seem to work
reliably: v86 with XO-1.5 and XO-1 upgraded to Sugar 0.84, Sugar-on-
a-Stick Strawberry (0.84) and Blueberry (0.86). Sugar 0.86 and above
(as of 9/2011) are compatible with Record v90, including XO's
updated to at least 0.90. Please note that Record prior to v74
(except for v61-64) produce ogg *speex* files; these files are
incompatible with SamplePlay.

Soundfiles must be moved into the folder where this file resides,
and be renamed soundin.0 (for the background loop) and soundin.1
through soundin.25 (for the samples). Alternatively, and more
practically, however, user soundfiles may be loaded/imported from the
Journal (Sugar 0.84 and later). In this case, only wav and ogg/vorbis
formats are allowed.

Unfortunately, no other Sugar activity (including TimeLapse,
ShowNTell, and most importantly, Etoys) produces soundfiles useable
by SamplePlay. Either they write files other than Ogg Vorbis or wav,
are restricted to Sugar 0.82, or their output is inaccessible to the
Journal and other activities (the case with Etoys).

More advanced users may wish to record their soundfiles on some other
system, and import their wav or ogg vorbis files into the Journal via
a USB drive. (Display USB contents in Journal view, and drag your
file onto the Journal icon.)

Otherwise, adventurous users may run the fine Audacity application to
record and edit. (Happily, none of the limitations of the Record
activity apply here.) In the Terminal, connected to the web, enter:
  su <Enter>
  yum import audacity <Enter>
  ...
  audacity <Enter>
(you are now running Audacity from the Terminal).

When you are finished recording and editing (including auditioning the
background loop in loop mode; pay particular attention to making the
loop point as inconspicuous as possible), "Export" the file in wav or
ogg vorbis format, saving it to a USB drive with appropriate filename.
Exit audacity. In the Journal, display the contents of your USB drive,
and drag your newly-recorded file onto the Journal icon. It is now
ready to import into SamplePlay.
 
It may be of interest that Oiseaux Ordinaires (the default soundfile
collection in SamplePlay) was recorded on the front stoop of the
author's home in Burlington, North Carolina, USA - early on a series
of summer mornings. He used a hand-held digital recorder, then
selected, edited and looped his sounds in Audacity. It was important
to record all sounds in the same environment and at the same level. An
ambient background loop of the location helped mask extraneous sounds
(for example, rumble and traffic noise). Use of the low-cut filter
option within SamplePlay also aided "homogenization."


MIDI Controller Hints (SamplePlay only)

Important: The controller must be attached AFTER boot, and BEFORE
the MIDI version is selected. It is assumed that the controller is a
USB device.

SamplePlay was specifically designed for two-octave or more (25+ key)
key) velocity-sensitive MIDI keyboards, preferably those with 1 or 2
additional sliders or modulation wheels (rotary knobs are OK, but not
as easy to work with). Suggested inexpensive USB models: Alesis Q25,
Akai LPK25 (no sliders/knobs), Korg nanoKey (no sliders/knobs and
rather flimsy construction), M-audio O2, and M-audio Oxygen8.

The Korg nanoKontrol is an adequate, if not ideal mini-controller for
SamplePlay; its 18 (not 25) buttons are not velocity-sensitive (it has
no pads or keys), and one of its four "Scenes" must be significantly
reprogrammed by the Korg Kontrol Editor to function with SamplePlay.
Though it has a multitude of programmable sliders and knobs,
unfortunately the buttons are not laid out well for SamplePlay
performance.


No Sound - Sample Rate Issues

On a few systems, e.g. the Intel Classmate PC, the specified sr
(sample rate) of 44100 may not produce audio. Substitute a rate of
48000 (or, if necessary, 32000) toward the beginning of each .csd
file, using a text editor.


Audio Glitching/Breakup

If you get audio glitching, open Sugar's Control Panel, and turn off
Extreme power management (under Power) or Wireless radio (under
Network). Reducing the Sample Rate to 32000 or even 24000 may be
necessary. A more drastic solution is to reduce textural density.

Stereo headphones (an inexpensive set will work fine) or external
amplifier/speaker system are highly recommended. Speakers built into
computers are fairly worthless musically.


Resizing the Font

The font display of this activity can be resized in csndsugui.py,
using any text editor. Further instructions are found toward the
beginning of csndsugui.py. (Simply change the value of the "resize"
variable (= 0), plus or minus.)


Further relevent items of interest may be found in the document
SamplePlay.txt on the author's website. (It is the text file
associated with the *all-platform* non-Sugar version of SamplePlay.)
With respect to this document, it is perhaps worth noting one
difference between the Sugar and non-Sugar versions of
SamplePlayASC: the key that triggers the background loop in the
Sugar version is "`" (to the left of numeral 1); in the all-platform
version it is the ENTER key.

Also, please be aware of one significant option available in
SamplePlay but not in SamplePlayASC: the "play sample only as long
as key is pressed" option. (In the ASC version, samples are always
played for their full duration, unless the "replace" function is
enabled.) 
