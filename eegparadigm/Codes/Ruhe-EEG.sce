/* Allg. Einstellungen:
Input Devices: Reaktionstaste [Tastatur Leertaste] einstellen
Port Settings: Einen Parallelport hinzuf�gen

Codes im EEG:
  1 - Taste gedr�ckt
  2 - Blickrichtung oben
  3 - Blickrichtung unten
  4 - Blickrichtung rechts
  5 - Blickrichtung links
  6 - Blickrichtung geradeaus
  7 - Augen auf
  8 - Augen zu
  9 - Augen zu beendet
 44 - Kopfrechnen Beginn
 55 - Kopfrechnen Ende
 99 - Ruhe Beginn
100 - Ruhe Ende */

#--header
scenario = "Ruhe-EEG";
pcl_file = "Ruhe-EEG.pcl";

default_background_color = 0, 0, 0;
default_font = "Arial";
default_font_size = 20;
default_text_align = align_left;
default_text_color = 255, 255, 255;

response_matching = simple_matching;
active_buttons = 1;
button_codes = 1;
write_codes = true;
pulse_width = 10;

begin;

#-- sdl part
picture {}default;

bitmap { filename = "Kopfrechnen.bmp";}bit1_kopfrechnen;
bitmap{ filename = "Ruhe bitte.bmp"; }bit2_ruhe;
bitmap{ filename = "Space.bmp"; }bit3_space;

sound{wavefile {filename = "instruktion_augenbewegungen.wav";};attenuation = .10;}sound1_instruktion_augenbewegungen;
sound{wavefile {filename = "augenbewegung_oben.wav";};attenuation = .14;}sound2_augenbewegung_oben;
sound{wavefile {filename = "augenbewegung_unten.wav";};attenuation = .14;}sound3_augenbewegung_unten;
sound{wavefile {filename = "augenbewegung_rechts.wav";};attenuation = .14;}sound4_augenbewegung_rechts;
sound{wavefile {filename = "augenbewegung_links.wav";};attenuation = .14;}sound5_augenbewegung_links;
sound{wavefile {filename = "augenbewegung_geradeaus.wav";};attenuation = .14;}sound6_augenbewegung_geradeaus;
sound{wavefile {filename = "instruktion_berger.wav";};attenuation = .10;}sound7_instruktion_berger;
sound{wavefile {filename = "augenoeffnung.wav";};attenuation = .10;}sound8_augenoeffnung;
sound{wavefile {filename = "augenschluss.wav";};attenuation = .10;}sound9_augenschluss;
sound{wavefile {filename = "instruktion_kopfrechnen.wav";};attenuation = .10;}sound10_instruktion_kopfrechnen;
sound{wavefile {filename = "ergebnis_kopfrechnen.wav";};attenuation = .14;}sound11_ergebnis_kopfrechnen;
sound{wavefile {filename = "instruktion_ruhe.wav";};attenuation = .10;}sound12_instruktion_ruhe;
sound{wavefile {filename = "ruhe_ende.wav";};attenuation = .10;}sound13_ruhe_ende;

text{
   caption = "
      Wir beginnen jetzt mit der Untersuchung.
      
      Als erstes m�chte ich Sie darum bitten,
      dass Sie Ihre Aug�pfel bei geschlossenen
      Augen in die jeweils von mir angesagte 
      Richtung bewegen.
      
      Wenn Sie keine Fragen mehr haben,
      schlie�en Sie bitte jetzt die Augen!
      ";
}text1_instruktion_augenbewegungen;

text{
   caption = "
     Nach oben!
     "; 
}text2_augenbewegung_oben;

text{
   caption = "
     unten!
     "; 
}text3_augenbewegung_unten;

text{
   caption = "
     rechts!
     "; 
}text4_augenbewegung_rechts;

text{
   caption = "
     links!
     "; 
}text5_augenbewegung_links;

text{
   caption = "
     und geradeaus!
     "; 
}text6_augenbewegung_geradeaus;

text{
   caption = "
      Bitte lassen Sie die Augen geschlossen!
      
      Als n�chstes m�chte ich Sie darum bitten,
      dass Sie ihre Augen auf meine Anweisung
      abwechselnd �ffnen und schlie�en.
      
      Wenn Sie keine Fragen mehr haben,
      f�hren wir die Untersuchung jetzt fort!
      ";
}text7_instruktion_berger;

text{
   caption = "
     Augen auf!
     "; 
}text8_augenoeffnung;

text{
   caption = "
     Augen zu!
     "; 
}text9_augenschluss;

text{
   caption = "
      Bitte lassen Sie die Augen geschlossen!
      
      Als n�chstes folgt eine Kopfrechenaufgabe. 
      Bitte ziehen Sie auf meine Anweisung von 
      100 fortlaufend 6 ab, bis ich Sie dazu 
      auffordere mir Ihr Ergebnis zu nennen.
      Halten Sie w�hrend des Rechnens bitte 
      ihre Augen geschlossen und sprechen Sie 
      nicht!
      
      Wenn Sie keine Fragen mehr haben,
      beginnen Sie bitte jetzt zu rechnen!
      ";
}text10_instruktion_kopfrechnen;

text{
   caption = "
      Kopfrechnen
   ";
}text11_kopfrechnen;

text{
   caption = "
      Bitte �ffnen Sie die Augen und nennen 
      Sie mir Ihr Ergebnis.
      
      [Ergebnis abwarten]
      
      Danke.
   ";
}text12_ergebnis_kopfrechnen;

text{
   caption = "
      Ich werde jetzt ein sogenanntes Ruhe-EEG 
      von Ihnen aufzeichnen.
      Dazu m�chte ich Sie bitten, sich f�r die 
      n�chsten 20 Minuten zu entspannen und 
      sich so wenig wie m�glich zu bewegen. 
      Bitte bem�hen Sie sich weder willentlich 
      einzuschlafen noch wach zu bleiben.
      Es ist wichtig, dass Sie Ihre Augen 
      w�hrend des gesamten Ruhe-EEGs 
      geschlossen halten. 
      
      Wenn Sie keine Fragen mehr haben,
      schlie�en Sie bitte jetzt die Augen!
   "; 
}text13_instruktion_ruhe;

text{
   caption = "
      - RUHE-EEG -
      Messung l�uft
   ";
}text14_ruhephase;

text{
   caption = "
     Die 20 Minuten sind vorbei. Damit ist der 
     erste Teil der Untersuchung beendet.
      
     Ich werde jetzt zu Ihnen in die Kabine 
     kommen und Ihnen das weitere Vorgehen 
     erkl�ren.
   ";
}text15_ruhe_ende;


trial{                                #Instruktion kontrollierte Augenbewegungen
   trial_duration = stimuli_length;
   stimulus_event{
      sound sound1_instruktion_augenbewegungen;
   }event1_instruktion_augenbewegungen;
   picture{
      text text1_instruktion_augenbewegungen;
      x = 0; y = 100;
   }pic1;
   time = 0;
   code = "Instruktion Augenbewegungen";
}trial1_instruktion_augenbewegungen; 

trial{                                
   trial_duration = forever;
   trial_type = first_response;
   picture{
      text text1_instruktion_augenbewegungen;
      x = 0; y = 100;
      bitmap bit3_space;
      x = 0; y = -280;
   }pic2;
   time = 0;
   code = "Nachfrage Instruktion Augenbewegungen";
}trial2_nachfrage_instruktion_augenbewegungen;

trial{                                # Augenbewegungen     
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound2_augenbewegung_oben;
	}event2_augenbewegung_oben;
   picture{
      text text2_augenbewegung_oben;
      x = 0; y = 0;
   }pic3;
   time = 0;
   duration = 2000;
   port_code = 2;
   code = "Augenbewegung nach oben";
}trial3_augenbewegung_oben;

trial{                                     
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound3_augenbewegung_unten;
	}event3_augenbewegung_unten;
   picture{
      text text3_augenbewegung_unten;
      x = 0; y = 0;
   }pic4;
   time = 0;
   duration = 2000;
   port_code = 3;
   code = "Augenbewegung nach unten";
}trial4_augenbewegung_unten;

trial{                                    
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound4_augenbewegung_rechts;
	}event4_augenbewegung_rechts;
   picture{
      text text4_augenbewegung_rechts;
      x = 0; y = 0;
   }pic5;
   time = 0;
   duration = 2000;
   port_code = 4;
   code = "Augenbewegung nach rechts";
}trial5_augenbewegung_rechts;
                             
trial{                                    
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound5_augenbewegung_links;
	}event5_augenbewegung_links;
   picture{
      text text5_augenbewegung_links;
      x = 0; y = 0;
   }pic6;
   time = 0;
   duration = 2000;
   port_code = 5;
   code = "Augenbewegung nach links";
}trial6_augenbewegung_links; 

trial{                                     
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound6_augenbewegung_geradeaus;
	}event6_augenbewegung_geradeaus;
   picture{
      text text6_augenbewegung_geradeaus;
      x = 0; y = 0;
   }pic7;
   time = 0;
   duration = 2000;
   port_code = 6;
   code = "Augenbewegung nach geradeaus";
}trial7_augenbewegung_geradeaus;

 trial{                                # Instruktion Berger-Man�ver
	trial_duration = stimuli_length;
	stimulus_event{
		sound sound7_instruktion_berger;
	}event7_instruktion_berger;
	picture{
		text text7_instruktion_berger;
		x = 0; y = 100;
  }pic8;
  time = 0;
  code = "Instruktion Berger-Man�ver";
}trial8_instruktion_berger;
 
trial{                               
	trial_duration = forever;
	trial_type = first_response;
	picture{
		text text7_instruktion_berger;
		x = 0; y = 100;
		bitmap bit3_space;
      x = 0; y = -280;
  }pic9;
  time = 0;
  code = "Nachfrage Instruktion Berger-Man�ver";
}trial9_nachfrage_instruktion_berger; 

trial{                                # Berger Man�ver      
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound8_augenoeffnung;
	}event8_augenoeffnung;
   picture{
      text text8_augenoeffnung;
      x = 0; y = 0;
   }pic10;
   time = 0;
   duration = 10000;
   port_code = 7;
   code = "Augen�ffnung";
}trial10_augenoeffnung;

trial{                                
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound9_augenschluss;
	}event9_augenschluss;
   picture{
      text text9_augenschluss;
      x = 0; y = 0;
   }pic11;
   time = 0;
   duration = 10000;
   port_code = 8;
   code = "Augenschluss";
}trial11_augenschluss;

trial{                                # Instruktion Kopfrechenaufgabe
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound10_instruktion_kopfrechnen;
	}event10_instruktion_kopfrechnen;
   picture{
      text text10_instruktion_kopfrechnen;
      x = 0; y = 100;
   }pic12;
   time = 0;
   code = "Instruktion Kopfrechenaufgabe";
}trial12_instruktion_kopfrechnen;

trial{                               
   trial_duration = forever;
   trial_type = first_response;
   picture{
      text text10_instruktion_kopfrechnen;
      x = 0; y = 100;
      bitmap bit3_space;
      x = 0; y = -300;
   }pic13;
   time = 0;
   code = "Nachfrage Instruktion Kopfrechenaufgabe";
}trial13_nachfrage_instruktion_kopfrechnen;

trial {                               # Kopfrechnen
   trial_duration = stimuli_length;
   picture{
      bitmap bit1_kopfrechnen;
      x = 45; y = -100;
		text text11_kopfrechnen;
      x = 0; y = 100;
   }pic14;
   time = 0;
   duration = 15000; 
   port_code = 44;
   code = "Kopfrechnen";
}trial14_kopfrechnen;

trial{                                # Kopfrechnen Ergbnis
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound11_ergebnis_kopfrechnen;
	}event11_ergebnis_kopfrechnen;
   picture{
      text text12_ergebnis_kopfrechnen;
      x = 0; y = 0; 
   }pic15;
   time = 0;
   port_code = 55;
   code = "Ergebnis Kopfrechnen";
}trial15_ergebnis_kopfrechnen;

trial{                                #Instruktion Ruhe-EEG
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound12_instruktion_ruhe;
	}event12_instruktion_ruhe;
   picture{
      text text13_instruktion_ruhe;
      x = 0; y = 100;
   }pic16;
   time = 0;
   code = "Instruktion Ruhe-EEG";
}trial16_instruktion_ruhe; 

trial{                               
   trial_duration = forever;
   trial_type = first_response;
   picture{
      text text13_instruktion_ruhe;
      x = 0; y = 100;
      bitmap bit3_space;
      x = 0; y = -300;
   }pic17;
   time = 0;
   code = "Nachfrage Instruktion Ruhe-EEG";
}trial17_nachfrage_instruktion_ruhe;

trial{                                #Ruhephase
   trial_duration = stimuli_length;
   picture{
      bitmap bit2_ruhe;
      x = 50; y = 220; 
      text text14_ruhephase;
      x = 0; y = -100;
   }pic18;
   time = 0;
   duration = 1200000;
   port_code = 99;
   code = "Begin Ruhe";
}trial18_ruhephase;

trial{                                #Ruhe Ende
   trial_duration = stimuli_length;
   stimulus_event{
		sound sound13_ruhe_ende;
	}event13_ruhe_ende;
   picture{
      text text15_ruhe_ende;
      x = 0; y = 0;
   }pic19; 
	time = 0;
	port_code =100;
	code = "Ruhe Ende";
}trial19_ruhe_ende;

trial{                                
   trial_duration = forever;
   trial_type = first_response;
   picture{
      text text15_ruhe_ende;
      x = 0; y = 0;
      bitmap bit3_space;
      x = 0; y = -280;
   }pic20; 
	time = 0;
	code = "Untersuchung Ende";
}trial20_untersuchung_ende;

trial{
   trial_duration = 2000;
}trail21_pause;

 trial{ 
   stimulus_event{
   picture default;
   port_code = 9;
   duration = 1000;  
   code = "Berger Man�ver, Ende"; 
   }event17_pause;
 }trial22_pause;
 
 trial{
   trial_duration = 10;
}trail23_pause;