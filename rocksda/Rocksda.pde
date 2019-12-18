/*
---Rocksda(v0.7)---
Made by Paxel Pager
*/

int stage = 0;
  
import processing.sound.*;
import java.util.Date;
import java.io.File;
import themidibus.*;
import java.io.File;
import java.util.Collection;
import javax.sound.midi.*;

boolean testmode = false;

float xman;


// genel elemanları
float score = 0;
float scoreC;
int hiz = 7;
int turn=0;
float time;

// Tasarım
screen menu,ingame,select;
String window = "menu";

color bg = color(10);
int sutunWidth = 150;
int sutunHeight = 1000;
int circleDia = 100;
int passin = 250;
int passout;

//   Müzik Hakkında

music msc;

// Kontrol Erkanı
int numKey = 4; 
public boolean[] keylist = new boolean [numKey];
boolean[] accesskey = new boolean[numKey];
boolean[] handylist = new boolean[numKey];
float[] actualimit = new float[numKey];
boolean[] emptyslot = new boolean[numKey];




color[] teamRenk = new color [11];
{
  teamRenk[0] = color(214, 4, 4);
  teamRenk[1] = color(30, 30, 200);
  teamRenk[2] = color(76, 222, 29);
  teamRenk[3] = color(140, 15, 191);
  teamRenk[4] = color(200, 210, 6);
  teamRenk[5] = color(122, 0, 211);
  teamRenk[6] = color(20, 200, 222);
  teamRenk[7] = color(222, 140, 16);
  teamRenk[8] = color(20, 200, 222);
  teamRenk[9] = color(20, 200, 222);
  teamRenk[10] = color(20, 200, 222);
}
///// objeler
timer clock;
SoundFile sf;

//////
float[] mymusic =  new float[10];

float horPos(int x, int weit) { //yatay alanı hesaplıyor
  float alan = numKey*weit;
  float ret = (width/2) - (alan/2);
  ret += x*sutunWidth; 
  return ret;
}

float fark;


File[] Songs;




/***************************************************************************************************************************************************/
void setup() {
  println("System Online");
  File f = new File(dataPath(""));
  Songs = f.listFiles();
  msc = new music();
  
  accesskey[0] = true;
  //noCursor();
  frameRate(60);
  fullScreen();
  colorMode(HSB);
  passout = height - 100;
  
  
  menu = new screen("menu");
  ingame = new screen("ingame");
  select = new screen("select");
  
  
  xman = width/2;
}


/***************************************************************************************************************************************************/
void soundload(String name){
  sf = new SoundFile(this,name);
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
        actualimit[note.sutun] = note.ctime;}
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
  
// Öte Nazi
  for (notebar note : msc.notes) {//bir notayı alıyor
    int j = note.sutun; // notanın sutununu öğreniyor
    
    if (note.turn) {   // nota sahnede mi

      //if (note.location.y>passout) {score-=15;scoreC=-15;note.kill();}// kaçanı vuruyoz

        //if (handylist[j]) {
        //  skorhesap(note.location.y);
        //  accesskey[j] = false;
        //  handylist[j] = false;
        //  note.kill();
        //}
      }
    }
 }

public void gezgin(int max){ //menü de gezmek için tuşları ayarlıyor
  for(int i=0;i<3;i++){
    if(!keylist[i]){ accesskey[i] = true;}
    if(accesskey[i]){     handylist[i]=keylist[i];    }
  }
  if(handylist[0]&& stage!=0){
    accesskey[0] = false;
    handylist[0] = false;
    stage--;
  }
  if(handylist[1]&& stage!=max){
    accesskey[1] = false;
    handylist[1] = false;
    stage++;
  }
  if(handylist[2]){
    accesskey[2] = false;
  }
}

void keyPressed() {
  for (int i = 0; i<numKey; i++) {
    if (key == 49+i) {keylist[i] = true;}
  }
  if(key == 120){testmode=true;}
  if(key == 121){testmode=false;}
}

void keyReleased() {
  for (int i = 0; i<numKey; i++) {
    if (key == 49+i) {keylist[i] = false;}
  }
}
