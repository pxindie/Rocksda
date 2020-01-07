import java.util.Date;

class screen{
  String name;
  int numsong;
  int songid;
  boolean stp = true;
  File pf;
  PImage menu,menutag,songcase,concert;
  PImage selectbg;
  PImage dark;
  
  float scotiDia =300;
   // animasyonla ilgili
  float alpha =0;
  boolean bigger = true;
  int timies;
  boolean begin = false;
  
  float katirs=250; //saatin bulunduğu çerçevenin kat sayısı
  
  int mbutn = 1; // Menü deki düğme sayısı
  button mbut;
  button[] sbut = new button[Songs.length];
  
  screen(String name_){
    name = name_;
    
    menu = loadImage(sketchPath("image\\menu.png"));
    menutag = loadImage(sketchPath("image\\tlat.png"));
    songcase = loadImage(sketchPath("image\\songcase.png"));
    selectbg = loadImage(sketchPath("image\\selectbg.jpg"));
    dark = loadImage(sketchPath("image\\dark.png"));
    concert = loadImage(sketchPath("image\\concert.jpg"));
  }
  
  void buttonUpdate(){
  if(stp){
    mbut = new button(0,0);
    
    int[] sutnes = new int[2];
    for(int i =0;i<Songs.length;i++){
        float xkom=0;
        int jahya=0;
        if(i<4){
          jahya = sutnes[0];
          xkom=width/4;
          sutnes[0]++;
        }else{
          jahya = sutnes[1];
          xkom=width/1.5;
          sutnes[1]++;
        }
        
      sbut[i] = new button(xkom-300,(jahya+0.7)*200-50);
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
    sont= true;
    imageMode(CENTER);
    tint(255,255);
    image(menu,width/2,height/2);
    menutag.resize(0,35);
    if(begin){
      accesskey[2]=false;
      handylist[2]=false;
      fastyblink();
      
    }else{
      blinkeffect();
    }
    image(menutag,width/2,height-300);
    if(testmode){
      textSize(20);
      text("[T Mode Active]",100,100);
    }
    gezgin(0);
    
      if(mbut.buton(stage==0,handylist[2])){
        handylist[2] = false;
        begin =true;
      }
    
    if(timies>=3){
      timies=0;
      window="select";
      stage=0;
      begin=false;
    }

  }






  void ingame() {  
    rectMode(CORNER);
      if(sont&&time>SongStartTime){sf[0].play(); sont = false;}
        imageMode(CENTER);
    tint(255,255);
    
    image(concert,width/2,height/2);
    //background(bg);
    for (int i = 0; i<numKey; i++) {
      float RectPos = horPos(i, sutunWidth);
      if (keylist[i]) {
        fill(reng(i,-50,200));
      } else {
        fill(255,255,255,150);
      }
      strokeWeight(7.0);
      noStroke(/*bg,bg,bg,150*/);
      rect(RectPos+10, passin, sutunWidth-10, sutunHeight);
      fill(#D3D3D3);  
      circle(RectPos+(sutunWidth/2), passout-100, circleDia);
    }
    fill(0,0,0,200);
    quad(width/2-katirs,0,  width/2+katirs,0,  width/2+katirs/2,katirs/2  ,width/2-katirs/2,katirs/2);
    strokeWeight(1.0);

    clock.showtime();
    scoretable();
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
    try{
    for (notebar note : msc.notes) {
      if(note.kontak){
      if (note.turn) { fill(#21CB00); } else { fill(#CB0018); }
        textSize(50);  
        //text("Turn : "  + note.turn, note.x+100, note.location.y);
        text("****Ray",note.x+100,note.raY);
        text(note.id+"-"+note.ctime,note.x+150,note.location.y+50);
    }}
    }catch(Exception ex){}
    //*************************************************************
  
  }
}
  
 

  void select(){
    selectbg.resize(0,1300);
    imageMode(CENTER);
    tint(255,255);
    image(selectbg,width/2,height/2);
    dark.resize(0,2000);
    tint(255,175);
    image(dark,width/2,height/2);
    
    gezgin(Songs.length-1);
    

    //text(stage,800,100);
        fps++;
    text(fps,width-100,100);
    for(int i = 0;i<Songs.length;i++){

        String neym = Songs[i].getName().replace(".mp3","");

        
        if(sbut[i].imgbuton(neym,stage==i,handylist[2],i)){
          handylist[2] = false;
          
        msc.adjust(i);    ;
          window = "ingame";
        }

    }
  }
  
  void highscores(){
    
  
  
  }
  void blinkeffect(){
    if(bigger){
      alpha+=3;
    }else{alpha-=3;}
    if(alpha>=255){bigger=false;}
    if(alpha<=100){bigger=true;}
    tint(255,alpha);
  }
  
  void fastyblink(){
   if(bigger){
     alpha+=25;
   }else{alpha-=25;}
   if(alpha>=255){bigger=false;}
   if(alpha<= 100){bigger=true;timies++;}
   tint(255,alpha);
   
  }
  
  void scoretable(){
    scotiDia+= scoreC*2;
    scoreC=0;
    if(scotiDia>300){scotiDia-=10;}
    if(scotiDia<300){scotiDia+=10;}
    
    fill(0,0,0,150);
    
    circle(width-350,600,scotiDia);
    PFont fontScore; // Score burda gösteriliyor
    fontScore = createFont("Bookman Old Style Kalın İtalik", 50);
    
    fill(250);
    textFont(fontScore);
    textAlign(CENTER);
    text(nf(score,0,1), width -350, 600);
    textSize(40);
    //String m;
    //if(scoreC<0){fill(#DE1013);m="";}else{fill(#08C909);m="+";}
    //text(m+scoreC, width -500, 650);
  
  }

}
