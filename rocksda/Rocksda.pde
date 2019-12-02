/*
---Guitarsda---
Paxel Pager
30.11.2019
*/

import themidibus.*;
import java.io.File;
import java.util.Collection;
import javax.sound.midi.*;

boolean testmode = true;


// genel elemanları
boolean a, b, c, d, sp, tetik;
int score = 0;
int scoreC;
int hiz = 7;
int turn=0;
float time;

// Tasarım

color bg = color(10);
int sutunWidth = 150;
int sutunHeight = 1000;
int circleDia = 100;
int passin = 250;
int passout;

// İmece usulu
int imgNum = 1;
PImage[] images = new PImage[imgNum];


//   Müzik Hakkında
int numNote = 30;
float songtime= 30;
int numSong=1;
boolean cooldown = false;
int playingMusic = 0;

// Kontrol Erkanı
int numKey = 4; 
boolean[] keylist = new boolean [numKey];
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
timer[] clocks = new timer[numSong];
music[] song = new music[1];
notebar[] notes = new notebar[numNote];
player player;
//////
float[] mymusic =  new float[10];

float horPos(int x, int weit) { //yatay alanı hesaplıyor
  float alan = numKey*weit;
  float ret = (width/2) - (alan/2);
  ret += x*sutunWidth; 
  return ret;
}

float fark;







/***************************************************************************************************************************************************/
void setup() {
  for(int i=0;i<imgNum;i++){
    String u = i + ".jpg";
    images[i] = loadImage(u);
  }
  accesskey[0] = true;
  //noCursor();
  frameRate(60);
  fullScreen();
  colorMode(HSB);
  passout = height - 100;
  for (int i = 0; i<clocks.length; i++) {
    clocks[i] = new timer(songtime);
  }

  for (int i = 0; i<notes.length; i++) {
    int j = int(random(numKey));
    notes[i] = new notebar(j, horPos(j, sutunWidth)+(sutunWidth/2), 1, hiz, i/*int(random(songtime))*/, notes, i, teamRenk[j], passin);
  }
}


/***************************************************************************************************************************************************/


void draw() {
  //makeup();
  //time = clocks[playingMusic].time();
  //for (notebar note : notes) {
  //  note.motor(time);
  //}
  //check();
}

/***************************************************************************************************************************************************/


void check() {
  for (int i = 0; i < numKey; i++) { //actualimit resetleniyor
    actualimit[i] = 1000000;
    emptyslot[i] = false;
  }

//   Tanı koyma
  for (int i=0; i<2; i++) { // önce actualimit belirleniyor  sonra da actualimite göre filitreleme yapılıyor
    for (notebar note : notes) {
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
  for (notebar note : notes) {//bir notayı alıyor
    int j = note.sutun; // notanın sutununu öğreniyor
    
    if (note.turn) {   // nota sahnede mi

      if (note.location.y>passout) {score-=15;scoreC=-15;note.kill();}// kaçanı vuruyoz

        if (handylist[j]) {
          skorhesap(note.location.y);
          accesskey[j] = false;
          handylist[j] = false;
          note.kill();
        }
      }
    }
  

}



void makeup() {
  background(bg);
  for (int i = 0; i<numKey; i++) {
    float RectPos = horPos(i, sutunWidth);
    if (keylist[i]) {
      fill(teamRenk[i]);
    } else {
      fill(#D3D3D3);
    }
    strokeWeight(7.0);
    stroke(bg);
    rect(RectPos, passin, sutunWidth, sutunHeight);
    fill(#D3D3D3);  
    circle(RectPos+(sutunWidth/2), passout-100, circleDia);
  }

  strokeWeight(1.0);
  fill(180);
  PFont fontScore;
  fontScore = createFont("BookmanOldStyle-Bold.vlw", 50);
  textFont(fontScore);
  text("Skor : " + score, width -500, 100);
  textSize(40);
  String m;
  if(scoreC<0){fill(#DE1013);m="";}else{fill(#08C909);m="+";}
  text(m+scoreC, width -500, 150);

  clocks[playingMusic].showtime(width);

  //*************************************************************
  if(testmode){
  for (int i =0; i<numKey; i++) {
    
    textSize(50);
    text("Key" + i +" "+ keylist[i], 100, i*50+200);
    text("Handy" + i +" "+ handylist[i], 500, i*50+200);
    text("Acces" + i +" "+ accesskey[i], 900, i*50+200);
    
    text(fark,100,800);
  }
  
  for (notebar note : notes) {
    if(note.kontak){
    if (note.turn) { fill(#21CB00); } else { fill(#CB0018); }
      textSize(50);  
      text("Turn : "  + note.turn, note.x+100, note.location.y);
  }}
  //*************************************************************
}
}

void keyPressed() {
  for (int i = 0; i<numKey; i++) {
    if (key == 49+i) {keylist[i] = true;}
  }
}

void keyReleased() {
  for (int i = 0; i<numKey; i++) {
    if (key == 49+i) {keylist[i] = false;}
  }
}


void skorhesap(float x) {
  fark = abs(x - (passout-100));

  if (fark>150) {
    score-=20;
    scoreC= -20;
  } else if (fark>15) {
    score +=10;
    scoreC = 10;
  } else {
    score +=20;
    scoreC =20;
  }
}

void menu(){
  

}
