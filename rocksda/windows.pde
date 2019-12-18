import java.util.Date;

class screen{
  String name;
  int numsong;
  int songid;
  boolean stp = true;
  
  int mbutn = 2; // Menü deki düğme sayısı
  button mbut;
  button[] sbut = new button[Songs.length];

  
  screen(String name_){
    name = name_;
    
  }
  
  void buttonUpdate(){
  if(stp){
    mbut = new button(30,300,60,20);
    for(int i =0;i<Songs.length;i++){
      sbut[i] = new button(50,600,100,25);
    }
    stp = false;
  }
  }
  
  void display(){
    buttonUpdate();
    switch(name){
      case "menu":
        menu();
        break;
      case "select":
        select();
        break;
      case "ingame":
        ingame();
        break;
     }
  }






  void menu(){
    if(testmode){
      text("--T Mode Active--",100,100);
    }
    mbut = new button(30,300,60,20);
    gezgin(1);
    background(bg);
    textAlign(CENTER);
    textSize(100);
    fill(250);
    text("Rocksda",xman,250);
      if(mbut.buton("Oyna",400,stage==0,handylist[2])){
        handylist[2] = false;
        window="select";
        stage=0;
        
      }
      if(mbut.buton("Çıkış",600,stage==1,handylist[2])){
        exit();
        stage=0;
      }  
  }






  void ingame() {
    rectMode(CORNER);
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
  
    clock.showtime();
  
    //*************************************************************
    if(testmode){
      textSize(10);
      text(clock.time(),100,900);
    for (int i =0; i<numKey; i++) {
      
      textSize(50);
      text("Key" + i +" "+ keylist[i], 100, i*50+200);
      text("Handy" + i +" "+ handylist[i], 500, i*50+200);
      text("Acces" + i +" "+ accesskey[i], 900, i*50+200);
      
      text(fark,100,800);
    }
    
    for (notebar note : msc.notes) {
      
      if(note.kontak){
      if (note.turn) { fill(#21CB00); } else { fill(#CB0018); }
        textSize(50);  
        text("Turn : "  + note.turn, note.x+100, note.location.y);
    }}
    //*************************************************************
  }
}
  
 

  void select(){
    gezgin(Songs.length-1);
    background(bg);
    
    for(int i = 0;i<Songs.length;i++){        
        String neym = Songs[i].getName().replace(".mp3","");
        
        if(sbut[i].buton(neym,(i+1)*150,stage==i,handylist[2])){
          handylist[2] = false;
          msc.adjust(Songs[i].getName());
          sf.play();
          window = "ingame";
        }

      }
    
    
    for(int i=0;i<numsong;i++){
      
    
    }
  
  
  
  }




}
