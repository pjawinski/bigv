/* Allg. Einstellungen:
Input Devices: Eine Reaktionstaste [Tastatur Leertaste] einstellen
Port Settings: Unter Port Output einen Parallelport hinzufÃ¼gen

Codes im EEG & Outputfile:
 1 - Taste gedrückt
10 - Standard
20 - Target */

#-- begin header --
scenario = "Novelty Instruktion";
pcl_file = "Novelty Instruktion.pcl";

default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size =20;
default_text_align = align_left;
default_text_color = 255, 255, 255;

response_matching = simple_matching;
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

sound{wavefile {filename = "instruktion_P3.wav";};attenuation = .19;}sound1_instruktion;
sound{wavefile {filename = "nachfrage.wav";};attenuation = .19;}sound2_nachfrage;
sound{wavefile {filename = "500Hz.wav";};attenuation = .25;}sound3_standard;
sound{wavefile {filename = "1000Hz.wav";};attenuation = .25;}sound4_target;

text {
   caption = "
      Bitte schließen Sie die Augen.
      
      Sie werden gleich zwei Töne hören, die sich in
      ihrer Tonhöhe voneinander unterscheiden.
      
      Bitte drücken Sie jedesmal die Taste wenn Sie
      den hohen Ton hören, beim tiefen Ton bitte nicht!
      Sie können jetzt erst einmal üben, die Töne zu 
      unterscheiden. Die Ergebnisse dieser Übung gehen
      nicht in die Auswertung ein.
      
      Wenn Sie keine Fragen mehr haben drücken Sie 
      bitte einmal die Taste wenn sie mit der Übung 
      beginnen möchten.
   ";
}text1_instruktion;

text {
   caption = "
      Haben Sie noch Fragen zur Übung?
      
      Wenn Sie keine Fragen mehr haben, schließen
      Sie bitte jetzt die Augen und wir beginnen 
      mit der Untersuchung.
   ";
} text2_nachfrage;

text {caption = "Standard";}text3_500Hz;
text {caption = "Target";}text4_1000Hz;

trial {										 # Instruktion
   trial_duration = forever;
   trial_type = first_response;
   stimulus_event{
		sound sound1_instruktion;
	}event1_instruktion;
	picture {
		text text1_instruktion;
		x = 0; y = 100;
	}pic1;
	time = 0;
	code = "Instruktion";
} trial1_instruktion;

trial { 										 # Nachfrage
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound2_nachfrage;
	}event2_nachfrage;
	picture{
		text text2_nachfrage;
		x = 0; y = 100;
	}pic3;
	time = 0;
	code = "Nachfrage";
} trail3_nachfrage;

trial { 										 
   trial_duration = forever;
   trial_type = first_response;
	picture{
		text text2_nachfrage;
		x = 0; y = 100; 
		bitmap bit3_space;
      x = 0; y = -280;
	}pic4;
	time = 0;
	code = "Nachfrage";
} trail4_ende_untersuchung;

trial{											#Standard
	trial_duration = 1500;
	stimulus_event{
		sound sound3_standard;
		time = 0;
		port_code = 10;
		code = "Standard";
	}event3_standard;
	picture{
		bitmap bit1_500Hz;
		x = 50; y = 220;
		text text3_500Hz;
		x = 0; y = -100;
	}pic5;
}trial5_standard;

trial{											#Target
	trial_duration = 1500;
	stimulus_event{
		sound sound4_target;
		time = 0;
		port_code = 20;
		code = "Target";
	}event4_target;
	picture{
	bitmap bit2_1000Hz;
	x = 50; y = 220;
	text text4_1000Hz;
	x = 0; y = -100;
	}pic6;
}trial6_target;

trial {trial_duration = 2000;}trial7_pause;