# SAMPLEPLAY - Audio Sample Player Utilities for Children (2011)
# Art Hunkins (www.arthunkins.com)
#   
#    Sampleplay is licensed under the Creative Commons Attribution-Share
#    Alike 3.0 Unported License. To view a copy of this license, visit
#    http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to
#    Creative Commons, 171 Second Street, Suite 300, San Francisco,
#    California, 94105, USA.
#
#    It is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# version 4:
#    documentation change

import csndsugui
from sugar.activity import activity
from sugar.graphics.objectchooser import ObjectChooser
from sugar import mime
import gtk
import os

class SamplePlay(activity.Activity):

 def __init__(self, handle):
  
   activity.Activity.__init__(self, handle)

   red = (0xDDDD, 0, 0)
   brown = (0x6600, 0, 0)
   green = (0, 0x5500, 0)
   self.paths = ["0"]*26
   self.jobjects = [None]*26
   self.buts = [None]*26

   win = csndsugui.CsoundGUI(self)
   width = gtk.gdk.screen_width()
   height = gtk.gdk.screen_height()
   if os.path.exists("/etc/olpc-release") or os.path.exists("/sys/power/olpc-pm"):
     adjust = 78
   else:
     adjust = 57
   screen = win.box()
   screen.set_size_request(width, height - adjust)
   scrolled = gtk.ScrolledWindow()
   scrolled.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
   screen.pack_start(scrolled)
   all = gtk.VBox()
   all.show()
   scrolled.add_with_viewport(all)
   scrolled.show()

   win.text("<big><b><big><u>SAMPLEPLAY</u> - Audio Sample Player \
Utilities for Children (2011)</big></b>\n\
\t\t\t    Art Hunkins (www.arthunkins.com)</big>", all)

   win.text("\
<b>SamplePlay</b> and <b>SamplePlayASC</b> play up to 25 mono/stereo samples and \
0 - 1 audio loops at the same time;\n\
    wav and ogg vorbis formats only (no ogg vorbis on Sugar 0.84).\n\
  User samples must be placed in Journal (Record activity \
does this). <b>No user files on Sugar 0.82</b> (original XO-1).\n\
  The default samples are those from the author's \
<b>OISEAUX ORDINAIRES</b>. You are urged to create your own!\t      ", all, brown)
   win.text("<b>SamplePlay</b> requires a MIDI controller, \
one key/button/pad per active sample (optionally velocity-sensitive);  \t\n  also \
(optionally) an additional key/button/pad and/or 1-3 MIDI knobs/sliders. \
All samples/MIDI notes are consecutive.", all, green)
   win.text("\
<i><b>MIDI</b>: plug in controller after boot &amp; before selecting version. \
Zero controls before start; reset pan &amp; pitch \
to .5 after.</i>", all, green)
   win.text("<b>SamplePlayASC</b> doesn't involve MIDI; \
control is via one or more ASCII keyboards.\n\
  <b>ASCII keys</b> used: (sample amplitude) 1-0(10); (pitch change, both + and -) \
SHIFTED 1-0(10);\n\
    (pan position, left/right) Z to / [all the above take effect with next keypress]; \
(samples 1-12 trigger) Q to ];\n\
    (samples 13-23) A to '; (sample 24) the - key, and \
(sample 25) the = key. The ` key starts/stops background loop.     ", all, brown)

   nbox = win.box(False, all)
   self.b2box = win.box(False, all)
   self.b3box = win.box(False, all)
   but1 = win.cbbutton(nbox, self.version1, "    1 SamplePlay     ")
   but1.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   but1.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   but2 = win.cbbutton(nbox, self.version2, " 2 SamplePlayASC ")
   but2.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   but2.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   win.text("<b>    MIDI DEVICE REQUIRED</b> for SamplePlay", nbox, green)

   try:
     from jarabe import config
     version = [int(i) for i in config.version.split('.')][:2]
   except ImportError:
     version = [0, 82]
   if version >= [0, 84]:
     win.text("  Optionally, <b>before choosing version</b>, \
select your own <b>audio</b> sample(s) and/or loop from Journal  \n\
  Deselect by closing Journal. Create soundfiles with Record activity \
or Audacity (see ReadMe.txt).", self.b2box, brown)
     win.text("  Load Loop\n  &amp; Samples", self.b2box, brown)
     self.buts[0] = win.cbbutton(self.b2box, self.choose0, "Loop")
     self.buts[0].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0x6600, 0, 0))
     win.text("", self.b3box, brown)
     for i in range(1, 26):
       self.buts[i] = win.cbbutton(self.b3box, self.choose, "%2d" %i)
       self.buts[i].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0x6600, 0, 0))

   bbox = win.box(False, all)
   self.bb = bbox
   self.w = win
   self.r = red
   self.g = green
   self.br = brown
   self.ver = 0
   self.kp = []

 def choose0(self, widget):
   chooser = ObjectChooser(parent=self, what_filter=mime.GENERIC_TYPE_AUDIO)
   result = chooser.run()
   if result == gtk.RESPONSE_ACCEPT:
     self.jobjects[0] = chooser.get_selected_object()
     self.paths[0] = str(self.jobjects[0].get_file_path())
     self.buts[0].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x8800, 0))
     self.buts[0].modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x8800, 0))
   else:
     self.paths[0] = "0"
     self.jobjects[0] = None
     self.buts[0].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0x6600, 0, 0))
     self.buts[0].modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0x6600, 0, 0))

 def choose(self, widget):
   chooser = ObjectChooser(parent=self, what_filter=mime.GENERIC_TYPE_AUDIO)
   result = chooser.run()
   index = self.b3box.child_get_property(widget, "position")
   if result == gtk.RESPONSE_ACCEPT:
     self.jobjects[index] = chooser.get_selected_object()
     self.paths[index] = str(self.jobjects[index].get_file_path())
     self.buts[index].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x8800, 0))
     self.buts[index].modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x8800, 0))
   else:
     self.paths[index] = "0"
     self.jobjects[index] = None
     self.buts[index].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0x6600, 0, 0))
     self.buts[index].modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0x6600, 0, 0))

 def send_data(self):
   for i in range(26):
     self.w.set_filechannel("file%d" % i, self.paths[i])

 def onKeyPress(self, widget, event):
   if self.p:  
     keyval = event.keyval
     if keyval in self.kp:
       return True
     self.kp.append(keyval)
     self.w.set_channel("ascii", keyval)
     return True

 def onKeyRelease(self, widget, event):
   self.kp.remove(event.keyval)
   self.w.set_channel("ascii", 0)
   return True

 def playcsd(self, widget):
   if self.p == False:
     self.p = True
     self.w.play()
     self.but.child.set_label("STOP !")
     self.but.child.set_use_markup(True)
     self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0xFFFF, 0, 0))
     self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0xFFFF, 0, 0))
     if self.ver > 1:
       self.connect("key-press-event", self.onKeyPress)
       self.connect("key-release-event", self.onKeyRelease)
   else:
     self.p = False
     self.w.recompile()
     self.w.channels_reinit()
     self.send_data()
     self.but.child.set_label("START !")
     self.but.child.set_use_markup(True)
     self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
     self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))

 def version1(self, widget):
   if self.ver != 0:
     self.box1.destroy()
     self.box2.destroy()
   else:
     self.b2box.destroy()
     self.b3box.destroy()
   self.ver = 1
   self.box1 = self.w.box(True, self.bb)
   self.w.text("", self.box1)
   self.box2 = self.w.box(True, self.bb)
   self.f = self.w.framebox(" <b>1 - Sampleplay</b> ", False, self.box2, self.r)
   self.b1 = self.w.box(True, self.f)
   self.b2 = self.w.box(True, self.f)
   self.b3 = self.w.box(True, self.f)
   self.b4 = self.w.box(True, self.f)
   self.b5 = self.w.box(True, self.f)
   self.b6 = self.w.box(True, self.f)
   self.w.reset()
   self.w.csd("SamplePlay.csd")
   self.w.spin(1, 1, 16, 1, 1, self.b1, 0, "Chan", "Channel #")
   self.w.spin(2, 0, 2, 1, 1, self.b1, 0, "Backgnd", "Background Loop\n\
[0=none 1=note\n  2=controller]")
   self.w.spin(10, 0, 30, 1, 1, self.b1, 0, "Bgmax", "Loop Lev [10=norm]")
   self.w.spin(7, 0, 127, 1, 1, self.b2, 0, "Stctrl", "Loop Controller #") 
   self.w.spin(84, 0, 127, 1, 1, self.b2, 0, "Stnote", " Loop Note\n\
(start/stop)")
   self.w.spin(5, 1, 30, 1, 1, self.b2, 0, "Stfade", "Start/Stop Secs")
   self.w.spin(25, 0, 25, 1, 1, self.b3, 0, "Samps", "# of Samples")
   self.w.spin(2, 0, 3, 1, 1, self.b3, 0, "Sampamp", "Sample Level Ctrl\n\
[0=none 1=rand\n2=note vel 3=ctrl]")
   self.w.spin(10, 0, 30, 1, 1, self.b3, 0, "Sampmax", "Overall Samp Lev\n\
    [10=norm]")
   self.w.spin(21, 0, 127, 1, 1, self.b4, 0, "Smpctrl", "Samp Lev Ctrl #")
   self.w.spin(60, 0, 103, 1, 1, self.b4, 0, "MIDI1", "1st MIDI Note #")
   self.w.spin(1, 0, 2, 1, 1, self.b4, 0, "Replace", " Replace Samps?\n\
    [0=overlap\n1=replace samp\n    2=sustain\n     keypress]")
   self.w.spin(0, 0, 3, 1, 1, self.b5, 0, "Smpfreq", "Samp Pitch Change\n\
   [0=none 1=rand\n  2=note vel 3=ctrl]")
   self.w.spin(22, 0, 127, 1, 1, self.b5, 0, "Frqctrl", "Pitch Controller #")
   self.w.spin(1, 0, 3, 1, 1, self.b5, 0, "Panpos", " Pan Pos Control\n\
[0=none 1=rand\n2=note vel 3=ctrl]")
   self.w.spin(23, 0, 127, 1, 1, self.b6, 0, "Panctrl", "Pan Position Ctrl #")
   self.w.button(self.b6, "Filter", "Low-cut Filter?")
   self.w.text("(for rumble/hum)", self.b6)
   self.w.spin(400, 50, 2000, 10, 100, self.b6, 0, "Cutoff", "Filt Cut Freq (Hz)")
   self.p = False
   self.w.text("\n<i>Select options first </i>", self.b6, self.g)
   self.send_data() 
   self.but = self.w.cbbutton(self.b6, self.playcsd, "START !")
   self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))

 def version2(self, widget):
   if self.ver != 0:
     self.box1.destroy()
     self.box2.destroy()
   else:
     self.b2box.destroy()
     self.b3box.destroy()
   self.ver = 2
   self.box1 = self.w.box(True, self.bb)
   self.w.text("\t\t\t   ", self.box1)
   self.box2 = self.w.box(True, self.bb)
   self.f = self.w.framebox(" <b>2 - SamplePlayASC</b> ", False, self.box2, self.r)
   self.b1 = self.w.box(True, self.f)
   self.b2 = self.w.box(True, self.f)
   self.b3 = self.w.box(True, self.f)
   self.b4 = self.w.box(True, self.f)
   self.w.reset()
   self.w.csd("SamplePlayASC.csd")
   self.w.text("", self.b1)
   self.w.button(self.b1, "Backgnd", "Background Loop?")
   self.w.text("(start/stop w/ ` key)", self.b1, self.g)
   self.w.spin(10, 0, 30, 1, 1, self.b1, 0, "Bgmax", "Loop Lev [10=norm]")
   self.w.spin(5, 1, 30, 1, 1, self.b1, 0, "Stfade", "Start/Stop Seconds")
   self.w.spin(25, 0, 25, 1, 1, self.b2, 0, "Samps", "# of Samples")
   self.w.spin(0, 0, 2, 1, 1, self.b2, 0, "Sampamp", "Sample Lev Ctrl\n\
[0=none 1=rand\n2=nums (0=10)]")
   self.w.spin(10, 0, 30, 1, 1, self.b2, 0, "Sampmax", "Overall Samp Lev\n\
    [10=norm]")
   self.w.button(self.b3, "Replace", "Replace Samps?")
   self.w.text("(0=overlap samps)", self.b3, self.g)
   self.w.spin(0, 0, 2, 1, 1, self.b3, 0, "Smpfreq", "Samp Pitch Change\n\
[0=none 1=rand 2=\nSHFT nums (0=10)]")
   self.w.spin(1, 0, 2, 1, 1, self.b3, 0, "Panpos", "Pan Position Control\n\
  [0=none 1=rand\n  2=bottom keys]")
   self.w.text("", self.b4)
   self.w.button(self.b4, "Filter", "Low-cut Filter?")
   self.w.text("(for rumble/hum)", self.b4)
   self.w.spin(400, 50, 2000, 10, 100, self.b4, 0, "Cutoff", "Filt Cut Freq (Hz)")
   self.p = False
   self.w.text("\n<i>Select options first </i>", self.b4, self.g)
   self.send_data() 
   self.but = self.w.cbbutton(self.b4, self.playcsd, "START !")
   self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
