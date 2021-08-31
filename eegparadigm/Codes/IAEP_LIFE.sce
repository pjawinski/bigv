/*Allg. Einstellungen:
Input Devices: Eine Reaktionstaste [Tastatur Leertaste] einstellen
Port Settings: Einen Parallelport hinzufügen

Codes im EEG:
 1 - Taste gedrückt
72 - Tonintensität 72 dB SPL
78 - Tonintensität 78 dB SPL
84 - Tonintensität 84 dB SPL
90 - Tonintensität 90 dB SPL
96 - Tonintensität 96 dB SPL
*/

#-- header --
scenario = "IAEP_LIFE";
pcl_file = "IAEP_LIFE.pcl";

default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size =20;
default_text_align = align_left;
default_text_color = 255, 255, 255;


active_buttons = 1;
button_codes = 1;
write_codes = true; 
pulse_width = 30;
scenario_type = trials;
no_logfile = false;

begin;             

#-- sdl part --

picture {} default;

bitmap{ filename = "Space.bmp"; }bit1_space;
 
wavefile {filename = "1000Hz_30ms.wav"; } ton;
sound { wavefile ton; attenuation = .09;} ton_96;                 
sound { wavefile ton; attenuation = .15;} ton_90;
sound { wavefile ton; attenuation = .21;} ton_84;
sound { wavefile ton; attenuation = .27;} ton_78;
sound { wavefile ton; attenuation = .33;} ton_72;

sound{ wavefile {filename = "instruktion_laap.wav";};attenuation = .19;}sound1_instruktion;
sound{ wavefile {filename = "laap_ende.wav";};attenuation = .19;}sound2_laap_ende;

text {caption = "96 dB";}text_96;
text {caption = "90 dB";}text_90;
text {caption = "84 dB";}text_84;
text {caption = "78 dB";}text_78;
text {caption = "72 dB";}text_72;

text{
	caption = "
Wir beginnen jetzt mit dem letzten Teil 
der Untersuchung. 
Im Folgenden werden Ihnen ca. 15 Minuten 
lang Töne verschiedener Intensität 
vorgespielt. Sie selbst müssen dazu nichts tun. 
Ihre einzige Aufgabe ist es, möglichst entspannt 
und ruhig zu sitzen.
Ihre Augen sollen während der gesamten Untersuchung 
offen bleiben. Schauen Sie bitte während der gesamten 
Zeit locker und entspannt auf das Kreuz vor Ihnen.
Falls Ihnen das irgendwann unangenehm wird, suchen
Sie sich bitte einen anderen Punkt, den Sie dann
locker anschauen. 

Wenn Sie keine Fragen mehr haben starte 
Ich jetzt die Tondarbietung.
	";
}text1_instruktion;

text{
	caption = "
	Die Untersuchung ist jetzt beendet.
	
	Ich werde jetzt zu Ihnen in die Kabnine kommen 
	und Ihnen das weitere Vorgehen erklären.";
}text2_laap_ende;

trial{                                # Anfangsinstruktion
	trial_duration = stimuli_length;
	stimulus_event{
		sound sound1_instruktion;
	}event1_instruktion;
	picture{
		text text1_instruktion;
		x = 0; y = 100;
  }pic1;
  time = 0;
  code = "Instruktion";
}trial1_instruktion;

trial{                               
	trial_duration = forever;
	trial_type = first_response;
	picture{
		text text1_instruktion;
		x = 0; y = 100;
		bitmap bit1_space;
      x = 0; y = -280;
  }pic2;
  time = 0;
  code = "Nachfrage Instruktion";
}trial2_nachfrage_instruktion;

trial{
	trial_duration = stimuli_length;				# Ende der Untersuchung
	stimulus_event{
		sound sound2_laap_ende;
	}event2_laap_ende;
	picture{
		text text2_laap_ende;
		x = 0; y = 100;
	}pic3;
	time = 0;
	code = "LAAP Ende";
}trial3_laap_ende;

trial{
	trial_duration = forever;
	trial_type = first_response;
	picture{
		text text2_laap_ende;
		x = 0; y = 100; 
		bitmap bit1_space;
      x = 0; y = -280;
	}pic4;
	time = 0;
	code = "Nachfrage LAAP Ende";
}trial4_nachfrage_laap_ende;

trial {
	stimulus_event{ sound ton_96; delta_time = 1600; port_code = 96; code = "96 dB";}event_96_1600;
	picture{ text text_96; x = 0; y = 0;}pic1_96;
}trial_96_1600;

trial { 
	stimulus_event{ sound ton_96; delta_time = 1700; port_code = 96; code = "96 dB";}event_96_1700;
	picture{ text text_96; x = 0; y = 0;}pic2_96;
}trial_96_1700;

trial {
	stimulus_event{ sound ton_96; delta_time = 1800; port_code = 96; code = "96 dB";}event_96_1800;
	picture{ text text_96; x = 0; y = 0;}pic3_96;
}trial_96_1800;

trial {
	stimulus_event{ sound ton_96; delta_time = 1900; port_code = 96; code = "96 dB";}event_96_1900;
	picture{ text text_96; x = 0; y = 0;}pic4_96;
}trial_96_1900;

trial {
	stimulus_event{ sound ton_96; delta_time = 2000; port_code = 96; code = "96 dB";}event_96_2000;
	picture{ text text_96; x = 0; y = 0;}pic5_96;
}trial_96_2000;

trial {
	stimulus_event{ sound ton_96; delta_time = 2100; port_code = 96; code = "96 dB";}event_96_2100;
	picture{ text text_96; x = 0; y = 0;}pic6_96;
}trial_96_2100;


trial {
	stimulus_event{ sound ton_90; delta_time = 1600; port_code = 90; code = "90 dB";}event_90_1600;
	picture{ text text_90; x = 0; y = 0;}pic1_90;
}trial_90_1600;

trial {
	stimulus_event{ sound ton_90; delta_time = 1700; port_code = 90; code = "90 dB";}event_90_1700;
	picture{ text text_90; x = 0; y = 0;}pic2_90;
}trial_90_1700;

trial {
	stimulus_event{ sound ton_90; delta_time = 1800; port_code = 90; code = "90 dB";}event_90_1800;
	picture{ text text_90; x = 0; y = 0;}pic3_90;
}trial_90_1800;

trial {
	stimulus_event{ sound ton_90; delta_time = 1900; port_code = 90; code = "90 dB";}event_90_1900;
	picture{ text text_90; x = 0; y = 0;}pic4_90;
}trial_90_1900;

trial {
	stimulus_event{ sound ton_90; delta_time = 2000; port_code = 90; code = "90 dB";}event_90_2000;
	picture{ text text_90; x = 0; y = 0;}pic5_90;
}trial_90_2000;

trial {
	stimulus_event{ sound ton_90; delta_time = 2100; port_code = 90; code = "90 dB";}event_90_2100;
	picture{ text text_90; x = 0; y = 0;}pic6_90;
}trial_90_2100;


trial {
	stimulus_event{ sound ton_84; delta_time = 1600; port_code = 84; code = "84 dB";}event_84_1600;
	picture{ text text_84; x = 0; y = 0;}pic1_84;
}trial_84_1600;

trial {
	stimulus_event{ sound ton_84; delta_time = 1700; port_code = 84; code = "84 dB";}event_84_1700;
	picture{ text text_84; x = 0; y = 0;}pic2_84;
}trial_84_1700;

trial {
	stimulus_event{ sound ton_84; delta_time = 1800; port_code = 84; code = "84 dB";}event_84_1800;
	picture{ text text_84; x = 0; y = 0;}pic3_84;
}trial_84_1800;

trial {
	stimulus_event{ sound ton_84; delta_time = 1900; port_code = 84; code = "84 dB";}event_84_1900;
	picture{ text text_84; x = 0; y = 0;}pic4_84;
}trial_84_1900;

trial {
	stimulus_event{ sound ton_84; delta_time = 2000; port_code = 84; code = "84 dB";}event_84_2000;
	picture{ text text_84; x = 0; y = 0;}pic5_84;
}trial_84_2000;

trial {
	stimulus_event{ sound ton_84; delta_time = 2100; port_code = 84; code = "84 dB";}event_84_2100;
	picture{ text text_84; x = 0; y = 0;}pic6_84;
}trial_84_2100;


trial {
	stimulus_event{ sound ton_78; delta_time = 1600; port_code = 78; code = "78 dB";}event_78_1600;
	picture{ text text_78; x = 0; y = 0;}pic1_78;
}trial_78_1600;

trial {
	stimulus_event{ sound ton_78; delta_time = 1700; port_code = 78; code = "78 dB";}event_78_1700;
	picture{ text text_78; x = 0; y = 0;}pic2_78;
}trial_78_1700;

trial {
	stimulus_event{ sound ton_78; delta_time = 1800; port_code = 78; code = "78 dB";}event_78_1800;
	picture{ text text_78; x = 0; y = 0;}pic3_78;
}trial_78_1800;

trial {
	stimulus_event{ sound ton_78; delta_time = 1900; port_code = 78; code = "78 dB";}event_78_1900;
	picture{ text text_78; x = 0; y = 0;}pic4_78;
}trial_78_1900;
	
trial {
	stimulus_event{ sound ton_78; delta_time = 2000; port_code = 78; code = "78 dB";}event_78_2000;
	picture{ text text_78; x = 0; y = 0;}pic5_78;
}trial_78_2000;	

trial {
	stimulus_event{ sound ton_78; delta_time = 2100; port_code = 78; code = "78 dB";}event_78_2100;
	picture{ text text_78; x = 0; y = 0;}pic6_78;
}trial_78_2100;


trial {
	stimulus_event{ sound ton_72; delta_time = 1600; port_code = 72; code = "72 dB";}event_72_1600;
	picture{ text text_72; x = 0; y = 0;}pic1_72;
}trial_72_1600;

trial {
	stimulus_event{ sound ton_72; delta_time = 1700; port_code = 72; code = "72 dB";}event_72_1700;
	picture{ text text_72; x = 0; y = 0;}pic2_72;
}trial_72_1700;

trial {
	stimulus_event{ sound ton_72; delta_time = 1800; port_code = 72; code = "72 dB";}event_72_1800;
	picture{ text text_72; x = 0; y = 0;}pic3_72;
}trial_72_1800;

trial {
	stimulus_event{ sound ton_72; delta_time = 1900; port_code = 72; code = "72 dB";}event_72_1900;
	picture{ text text_72; x = 0; y = 0;}pic4_72;
}trial_72_1900;

trial {
	stimulus_event{ sound ton_72; delta_time = 2000; port_code = 72; code = "72 dB";}event_72_2000;
	picture{ text text_72; x = 0; y = 0;}pic5_72;
}trial_72_2000;

trial {
	stimulus_event{ sound ton_72; delta_time = 2100; port_code = 72; code = "72 dB";}event_72_2100;
	picture{ text text_72; x = 0; y = 0;}pic6_72;
}trial_72_2100;

trial{
   trial_duration = 2000;
}trail5_pause;