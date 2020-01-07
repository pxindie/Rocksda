 /*
---Rocksda(v0.9)---
Made by Paxel Pager
*/
int fps;

int stage = 0;
 
import processing.serial.*;
import processing.sound.*;
import java.util.Date;
import java.io.File;
import themidibus.*;
import java.io.File;
import java.util.Collection;
import javax.sound.midi.*;
import java.io.FilenameFilter;

boolean testmode = false;
float xman;

float perlimit=750;
// genel elemanları
float score = 0;
float scoreC;
int hiz = 6;
int turn=0;
float time;


// Tasarım
PImage enterpaper,lopera,loperb,gampaper;
String window = "menu";

color bg = color(0);
int sutunWidth = 150;
int sutunHeight = 1000;
int circleDia = 100;
int passin = 250;
int passout;

// FONT
PFont fondy,fontTime;



//   Müzik Hakkında
boolean sont;
float SongStartTime = 4200;


// Kontrol Erkanı
int numKey = 4; 
int exKey = 3;
int totalKey= numKey + exKey;

public boolean[] keylist = new boolean [totalKey];
boolean[] accesskey = new boolean[totalKey];
boolean[] handylist = new boolean[totalKey];
float[] actualimit = new float[numKey];
boolean[] emptyslot = new boolean[numKey];


//  Serial Elemanları
Serial port;

color reng(int v,int dark,int soft){
  color[] teamRenk = new color [11];
  {
    teamRenk[0] = color(214+dark, 4+dark, 4+dark,soft);
    teamRenk[1] = color(30+dark, 30+dark, 200+dark,soft);
    teamRenk[2] = color(76, 222+dark, 29+dark,soft);
    teamRenk[3] = color(140+dark, 15+dark, 191+dark,soft);
    teamRenk[4] = color(200+dark, 210+dark, 6+dark,soft);
    teamRenk[5] = color(122+dark, 0+dark, 211+dark,soft);
    teamRenk[6] = color(20+dark, 200+dark, 222+dark,soft);
    teamRenk[7] = color(222+dark, 140+dark, 16+dark,soft);
    teamRenk[8] = color(20+dark, 200+dark, 222+dark,soft);
    teamRenk[9] = color(20+dark, 200+dark, 222+dark,soft);
    teamRenk[10] = color(20+dark, 200+dark, 222+dark,soft);
  }
  
  return teamRenk[v];
}

///// objeler
timer clock;
SoundFile[] sf;
XML[] xf;
screen menu,ingame,select,esc;
File f;
hiscore hs;
music msc;
//////

float horPos(int x, int weit) { //yatay alanı hesaplıyor
  float alan = numKey*weit;
  float ret = (width/2) - (alan/2);
  ret += x*sutunWidth; 
  return ret;
}

float fark;

File[] exc;
File[] Songs;
File[] xSongs;





/***************************************************************************************************************************************************/

void setup() {
  noCursor();
  //println(PFont.list());
  //port = new Serial(this,Serial.list()[0], 9600);
  //port.bufferUntil('n');
  println("-----------------System Online-----------------");
  
  fontTime = createFont("Courier New",100);
  fondy = createFont("Verdana Bold Italic",48);

  f = new File(sketchPath("\\chords"));
  xSongs = f.listFiles();
  //println(xSongs);

  xf = new XML[xSongs.length];
  
  
  f = new File(dataPath(""));
  exc = f.listFiles();
  Songs = new File[xSongs.length];
  
  int takkuyyit=0; // a random varible
  for(int i=0;i<exc.length;i++){
    if(exc[i].getName().contains(".mp3")){
      Songs[takkuyyit] = exc[i];
      takkuyyit++;
    }
  }
  sf = new SoundFile[Songs.length];
  
  
  msc = new music();
  
  accesskey[0] = true;
  frameRate(60);
  fullScreen();
  //colorMode(HSB);
  passout = height - 100;
  
  
  menu = new screen("menu");
  ingame = new screen("ingame");
  select = new screen("select");
  
  
  xman = width/2;
  soundload();

  hs = new hiscore();
  hs.startup();

}


/***************************************************************************************************************************************************/
void soundload(){
  for(int i =0;i<Songs.length;i++){
    sf[i] = new SoundFile(this,Songs[i].getName());
    xf[i] = loadXML(xSongs[i].getPath());
  }
}


void draw() {
  switch(window){
    case "menu":
      menu.display();
      break;
    case "select":
      select.display();
      break;
   
    case "ingame":
      ingame.display();
      time = clock.time();
      msc.run();
      check();
      break;
 
  }

}

/***************************************************************************************************************************************************/


void check() {
  for (int i = 0; i < numKey; i++) { //actualimit resetleniyor
    actualimit[i] = 1000000;
    emptyslot[i] = false;
  }

//   Tanı koyma
  for (int i=0; i<2; i++) { // önce actualimit belirleniyor  sonra da actualimite göre filitreleme yapılıyor
    for (notebar note : msc.notes) {
      if(note.turn){
        emptyslot[note.sutun]= true;
      }
      if (i==0 && note.kontak && note.ctime<actualimit[note.sutun]) { 
        actualimit[note.sutun] = note.ctime;
      }
      if (actualimit[note.sutun] == note.ctime) {note.turn = true;}
    }
  }
  
  
  
  for(int i=0;i<numKey;i++){
    if(!keylist[i]){ accesskey[i] = true;}
    if(accesskey[i]){     handylist[i]=keylist[i];    }
    if(handylist[i]&&!emptyslot[i]){
          score-=5;
          scoreC=-5;
          accesskey[i] = false;
          handylist[i] = false;}
  }
 }

public void gezgin(int max){ //menü de gezmek için tuşları ayarlıyor
  for(int i=0;i<3;i++){
    if(!keylist[i]){ accesskey[i] = true;}
    if(accesskey[i]){     handylist[i]=keylist[i];    }
  }
  if(handylist[0]){
    accesskey[0] = false;
    handylist[0] = false;
    if(stage!=0){stage--;}else{stage=max;}
  }
  if(handylist[1]){
    accesskey[1] = false;
    handylist[1] = false;
    if(stage!=max){stage++;}else{stage=0;}
  }
  
  if(handylist[2]){
    accesskey[2] = false;
  }
}

void serialEvent(Serial p){
  String data = p.readStringUntil('n');
  for (int i = 0; i<totalKey; i++) {
    print(" waiting : "+i);
    if(matchAll(data,str(i))!=null) {keylist[i] = true;}
    else{keylist[i]=false;}
  }
}

void keyPressed() {
  for (int i = 0; i<numKey; i++) {
    if (key == 49+i) {keylist[i] = true;}
  }
  
  
  
  if(key==27){
   key = 0;
   if(window=="menu"){exit();}else{
   window="menu";
   sf[0].pause();
   }
  }
  if(key=='p'){
  noLoop();
  }
}

void keyReleased() {
  for (int i = 0; i<numKey; i++) {
    if (key == 49+i) {keylist[i] = false;}
  }
  if(key=='o'){loop();}
}
