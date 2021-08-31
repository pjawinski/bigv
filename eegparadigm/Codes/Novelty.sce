/* Allg. Einstellungen:
Input Devices: Eine Reaktionstaste [Tastatur Leertaste] einstellen
Port Settings: Unter Port Output einen Parallelport hinzufügen

Codes im EEG & Outputfile:
 1 - Taste gedrückt
10 - Standard
20 - Target
30 - Novelty
33 - Wechsel der Reaktionshand

11 - Falcher Alarm
21 - Korrekte Ablehnung
12 - Treffer
22 - Verpasser */

#-- begin header --
scenario = "Novelty";
pcl_file = "Novelty.pcl";

default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size =28;
default_text_align = align_left;
default_text_color = 255, 255, 255;

response_matching = simple_matching;
response_port_output = true;
scenario_type = trials;
active_buttons = 1;
button_codes = 1;
write_codes = true;
pulse_width = 20;

begin; 

#-- sdl part --
picture {} default;

bitmap{ filename = "500Hz.bmp";}bit1_500Hz;
bitmap{ filename = "1000Hz.bmp";}bit2_1000Hz; 
bitmap{ filename = "Space.bmp"; }bit3_space;

sound{wavefile {filename = "500Hz.wav";};attenuation = .25;}sound1_standard;
sound{wavefile {filename = "1000Hz.wav";};attenuation = .25;}sound2_target;
sound{wavefile {filename = "pause.wav";};attenuation = .19;}sound3_pause;
sound{wavefile {filename = "P3_ende.wav";};attenuation = .19;}sound76_ende;

sound{wavefile {filename = "BNPECKER.wav";};attenuation = .25;}sound4;
sound{wavefile {filename = "BNOWL1.wav";};attenuation = .25;}sound5;
sound{wavefile {filename = "BNRAVEN.wav";};attenuation = .25;}sound6;
sound{wavefile {filename = "BOBIRD.wav";};attenuation = .25;}sound7;
sound{wavefile {filename = "BNCHICKN.wav";};attenuation = .25;}sound8;
sound{wavefile {filename = "ANSEALIO.wav";};attenuation = .25;}sound9;
sound{wavefile {filename = "ANSHEEP.wav";};attenuation = .25;}sound10;
sound{wavefile {filename = "ANCAT2.wav";};attenuation = .25;}sound11;
sound{wavefile {filename = "ANCHIMP2.wav";};attenuation = .25;}sound12;
sound{wavefile {filename = "ANHORSE2.wav";};attenuation = .25;}sound13;
sound{wavefile {filename = "ANWHALE.wav";};attenuation = .25;}sound14;
sound{wavefile {filename = "AOWOLF.wav";};attenuation = .25;}sound15;
sound{wavefile {filename = "AOCOW.wav";};attenuation = .25;}sound16;
sound{wavefile {filename = "ANCRICKT.wav";};attenuation = .25;}sound17;
sound{wavefile {filename = "AODOG.wav";};attenuation = .25;}sound18;
sound{wavefile {filename = "HNPRRRR.wav";};attenuation = .25;}sound19;
sound{wavefile {filename = "NNEXPLOS.wav";};attenuation = .25;}sound20;
sound{wavefile {filename = "ANFROG1.wav";};attenuation = .25;}sound21;
sound{wavefile {filename = "MNBUGLE.wav";};attenuation = .25;}sound22;
sound{wavefile {filename = "NNDENTST.wav";};attenuation = .25;}sound23;
sound{wavefile {filename = "NNRACE.wav";};attenuation = .25;}sound24;
sound{wavefile {filename = "NNWATER3.wav";};attenuation = .25;}sound25;
sound{wavefile {filename = "HNBABY.wav";};attenuation = .25;}sound26;
sound{wavefile {filename = "HNCOUGH2.wav";};attenuation = .25;}sound27;
sound{wavefile {filename = "HNLAUGH.wav";};attenuation = .25;}sound28;
sound{wavefile {filename = "VNCARTOO.wav";};attenuation = .25;}sound29;
sound{wavefile {filename = "MOSYNTH.wav";};attenuation = .25;}sound30;
sound{wavefile {filename = "MNSYNTH1.wav";};attenuation = .25;}sound31;
sound{wavefile {filename = "NNCUCKOO.wav";};attenuation = .25;}sound32;
sound{wavefile {filename = "MNNOTES.wav";};attenuation = .25;}sound33;
sound{wavefile {filename = "MOPIANO.wav";};attenuation = .25;}sound34;
sound{wavefile {filename = "MNTRIANG.wav";};attenuation = .25;}sound35;
sound{wavefile {filename = "MNCYMBAL.wav";};attenuation = .25;}sound36;
sound{wavefile {filename = "VNBOING1.wav";};attenuation = .25;}sound37;
sound{wavefile {filename = "VNGAME1.wav";};attenuation = .25;}sound38;
sound{wavefile {filename = "VNGAME5.wav";};attenuation = .25;}sound39;
sound{wavefile {filename = "BOLOONS.wav";};attenuation = .25;}sound40;
sound{wavefile {filename = "BNOWL2.wav";};attenuation = .25;}sound41;
sound{wavefile {filename = "BOCROW.wav";};attenuation = .25;}sound42;
sound{wavefile {filename = "BNWHIP.wav";};attenuation = .25;}sound43;
sound{wavefile {filename = "BNTURKEY.wav";};attenuation = .25;}sound44;
sound{wavefile {filename = "HNNOSE.wav";};attenuation = .25;}sound45;
sound{wavefile {filename = "HNSPEEC2.wav";};attenuation = .25;}sound46;
sound{wavefile {filename = "HNBELCH2.wav";};attenuation = .25;}sound47;
sound{wavefile {filename = "ANHORSE1.wav";};attenuation = .25;}sound48;
sound{wavefile {filename = "HNHICCUP.wav";};attenuation = .25;}sound49;
sound{wavefile {filename = "HNCLAP.wav";};attenuation = .25;}sound50;
sound{wavefile {filename = "ANMOSQUI.wav";};attenuation = .25;}sound51;
sound{wavefile {filename = "AOPIG.wav";};attenuation = .25;}sound52;
sound{wavefile {filename = "ANCAT1.wav";};attenuation = .25;}sound53;
sound{wavefile {filename = "NNRATTLE.wav";};attenuation = .25;}sound54;
sound{wavefile {filename = "BNLIMPKN.wav";};attenuation = .25;}sound55;
sound{wavefile {filename = "MNSYNTH2.wav";};attenuation = .25;}sound56;
sound{wavefile {filename = "NOSAW2.wav";};attenuation = .25;}sound57;
sound{wavefile {filename = "VNGUN2.wav";};attenuation = .25;}sound58;
sound{wavefile {filename = "NNCAR.wav";};attenuation = .25;}sound59;
sound{wavefile {filename = "NNHELICO.wav";};attenuation = .25;}sound60;
sound{wavefile {filename = "NNTRAIN.wav";};attenuation = .25;}sound61;
sound{wavefile {filename = "VOOOAHOO.wav";};attenuation = .25;}sound62;
sound{wavefile {filename = "HNCOUGH1.wav";};attenuation = .25;}sound63;
sound{wavefile {filename = "HNKISS.wav";};attenuation = .25;}sound64;
sound{wavefile {filename = "HNWHISTL.wav";};attenuation = .25;}sound65;
sound{wavefile {filename = "VNWHISTL.wav";};attenuation = .25;}sound66;
sound{wavefile {filename = "MNDRUM.wav";};attenuation = .25;}sound67;
sound{wavefile {filename = "MNPICCOL.wav";};attenuation = .25;}sound68;
sound{wavefile {filename = "MNGUITAR.wav";};attenuation = .25;}sound69;
sound{wavefile {filename = "MNXYLOP2.wav";};attenuation = .25;}sound70;
sound{wavefile {filename = "VOTWEEE.wav";};attenuation = .25;}sound71;
sound{wavefile {filename = "MNTYMPAN.wav";};attenuation = .25;}sound72;
sound{wavefile {filename = "VNGADGET.wav";};attenuation = .25;}sound73;
sound{wavefile {filename = "VNGAME4.wav";};attenuation = .25;}sound74;
sound{wavefile {filename = "VNPINBAL.wav";};attenuation = .25;}sound75;


text {caption = "Standard";}text1_500Hz;
text {caption = "Target";}text2_1000Hz;
text {caption = "
         Bitte lassen Sie die Augen geschlossen.
         
         Bitte nehmen Sie den Taster jetzt in
         die andere Hand und warten Sie bis
         die Untersuchung fortgesetzt wird.
      ";
 }text3_pause;
text {caption = "novelty";}text4_novelty;
text {caption = "
   Der zweite Teil der Untersuchung ist beendet. 
   
   Ich werde jetzt zu Ihnen in die Kabine kommen 
   und Ihnen das weitere Vorgehen erklären.
		";
}text5_P3_ende;

trial{											#Standard
	trial_duration = 1500;
	stimulus_event{
		sound sound1_standard;
		time = 0;
		response_active = true;
		stimulus_time_in = 0;
		stimulus_time_out = never;
		port_code = 10;
		code = "Standard";
	}event1_standard;
	picture{
		bitmap bit1_500Hz;
		x = 50; y = 220;
		text text1_500Hz;
		x = 0; y = -100;
	}pic1;
}trial1_standard;

trial{											#Target
	trial_duration = 1500;
	stimulus_event{
		sound sound2_target;
		time = 0;
		target_button = 1;
		stimulus_time_in = 100;
		stimulus_time_out = never;
		port_code = 20;
		code = "Target";
	}event2_target;
	picture{
	bitmap bit2_1000Hz;
	x = 50; y = 220;
	text text2_1000Hz;
	x = 0; y = -100;
	}pic2;
}trial2_target;

trial {trial_duration = 2000;}trial3_verzoegerung;

trial{                                #Pause
   trial_duration = 30000;
   stimulus_event{
      sound sound3_pause;
      time = 0;
      port_code = 33;
      code = "Pause";
   }event3_pause;
   picture{
      text text3_pause;
      x = 0; y = 0;
   }pic3;
}trial4_pause;

trial{											#Novelty - Trials
	trial_duration = 1500;
	stimulus_event{
		sound sound4;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event4;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic4;
}trial4;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound5;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event5;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic5;
}trial5;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound6;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event6;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic6;
}trial6;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound7;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event7;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic7;
}trial7;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound8;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event8;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic8;
}trial8;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound9;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event9;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic9;
}trial9;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound10;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event10;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic10;
}trial10;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound11;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event11;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic11;
}trial11;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound12;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event12;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic12;
}trial12;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound13;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event13;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic13;
}trial13;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound14;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event14;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic14;
}trial14;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound15;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event15;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic15;
}trial15;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound16;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event16;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic16;
}trial16;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound17;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event17;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic17;
}trial17;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound18;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event18;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic18;
}trial18;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound19;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event19;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic19;
}trial19;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound20;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event20;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic20;
}trial20;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound21;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event21;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic21;
}trial21;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound22;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event22;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic22;
}trial22;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound23;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event23;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic23;
}trial23;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound24;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event24;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic24;
}trial24;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound25;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event25;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic25;
}trial25;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound26;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event26;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic26;
}trial26;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound27;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event27;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic27;
}trial27;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound28;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event28;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic28;
}trial28;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound29;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event29;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic29;
}trial29;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound30;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event30;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic30;
}trial30;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound31;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event31;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic31;
}trial31;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound32;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event32;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic32;
}trial32;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound33;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event33;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic33;
}trial33;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound34;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event34;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic34;
}trial34;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound35;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event35;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic35;
}trial35;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound36;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event36;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic36;
}trial36;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound37;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event37;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic37;
}trial37;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound38;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event38;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic38;
}trial38;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound39;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event39;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic39;
}trial39;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound40;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event40;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic40;
}trial40;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound41;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event41;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic41;
}trial41;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound42;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event42;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic42;
}trial42;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound43;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event43;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic43;
}trial43;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound44;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event44;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic44;
}trial44;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound45;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event45;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic45;
}trial45;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound46;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event46;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic46;
}trial46;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound47;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event47;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic47;
}trial47;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound48;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event48;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic48;
}trial48;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound49;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event49;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic49;
}trial49;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound50;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event50;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic50;
}trial50;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound51;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event51;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic51;
}trial51;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound52;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event52;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic52;
}trial52;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound53;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event53;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic53;
}trial53;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound54;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event54;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic54;
}trial54;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound55;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event55;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic55;
}trial55;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound56;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event56;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic56;
}trial56;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound57;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event57;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic57;
}trial57;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound58;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event58;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic58;
}trial58;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound59;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event59;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic59;
}trial59;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound60;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event60;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic60;
}trial60;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound61;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event61;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic61;
}trial61;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound62;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event62;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic62;
}trial62;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound63;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event63;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic63;
}trial63;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound64;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event64;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic64;
}trial64;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound65;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event65;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic65;
}trial65;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound66;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event66;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic66;
}trial66;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound67;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event67;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic67;
}trial67;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound68;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event68;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic68;
}trial68;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound69;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event69;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic69;
}trial69;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound70;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event70;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic70;
}trial70;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound71;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event71;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic71;
}trial71;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound72;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event72;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic72;
}trial72;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound73;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event73;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic73;
}trial73;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound74;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event74;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic74;
}trial74;

trial{											
	trial_duration = 1500;
	stimulus_event{
		sound sound75;
		time = 0;
		port_code = 30;
		code = "Novelty";
	}event75;
	picture{
	text text4_novelty;
	x = 0; y = -100;
	}pic75;
}trial75;

trial{                                # Ende
	trial_duration = stimuli_length;
	stimulus_event{
		sound sound76_ende;
	}event76_ende;
	picture{
		text text5_P3_ende;
		x = 0; y = 100;
  }pic76;
  time = 0;
  code = "Untersuchungsende";
}trial76_ende;

trial{                              
	trial_duration = forever;
	trial_type = first_response;
	picture{
		text text5_P3_ende;
		x = 0; y = 100;
		bitmap bit3_space;
      x = 0; y = -280;
  }pic77;
  time = 0;
  code = "Untersuchungsende";
}trial77_ende;