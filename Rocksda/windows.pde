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
  PFont fontScore =  createFont("Bookman Old Style Kalın İtalik", 50);
  float scotiDia =300;
   // animasyonla ilgili
  float alpha =0;
    int apassed=1 ;
  boolean bigger = true;
  int timies;
  boolean begin = false;
   //alfalar için
  float katirs=250; //saatin bulunduğu çerçevenin kat sayısı
  
  // Skor falan
  
  int rekor =  0;
  int fark =  0;
  String geyepod ="";
  int gentle =0;
  int entercet=0;
  char[] input = new char[10];
  
  int sgk; //song numbe key 
  int[] sts = new int[10];
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
      case "skor":
        skor();
        break;
     }
  }






  void menu(){
    skor.rekor=0;
    skor.fark=0;
    skor.gentle=0;
    skor.entercet=0;
    for(int i=0;i<input.length;i++){
      skor.input[i]=0;
    }
    for(int i=0;i<sts.length;i++){
      skor.sts[i]=0;
    }
    
    
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
    if(msc.end){gotoskor();}
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
    score=0;

    selectbg.resize(0,1300);
    imageMode(CENTER);
    tint(255,255);
    image(selectbg,width/2,height/2);
    dark.resize(0,2000);
    tint(255,175);
    image(dark,width/2,height/2);
    
    gezgin(Songs.length-1);
    
    for(int i = 0;i<Songs.length;i++){

        String neym = Songs[i].getName().replace(".mp3","");

        
        if(sbut[i].imgbuton(neym,stage==i,handylist[2],i)){
          skor.sgk = i;
          handylist[2] = false;
          msc.end=false;
          msc.adjust(i);
          window = "ingame";
        }
    }
  }
  
  void skor(){
    switch(gentle){
      case 0:
      PFont fb = createFont("Agency FB",20);
      PFont fbk = createFont("Agency FB kalın",20);
      background(0);
      
      
      textFont(fbk);
      textSize(150);
      getin(0,"Müzik Bitti",width/2,230);
      higuys("update");
      textFont(fb);
      textSize(60);
      if(sts[0]==0){delay(2000);}
      if(sts[0]==255){
        if(sts[1]==0){delay(2000);}
        getin(1,"Skor: "+int(score),width/2,350);
        if(sts[2]==0&&sts[1]==255){delay(1000);}
        if(sts[1]==255){
        if(rekor==0){
          getin(2,"Adını yazdırabilmek için\n"+fark+"\ndaha puana ihtiyacın var",width/2,600);
          if(sts[2]==255 && keyPressed){
            handylist[totalKey-1]=false;
            accesskey[totalKey-1]=false;
            gentle=2;
          }
        }else{
          if(rekor==1){
          getin(2,"Kaptın birinciliği Şampiyon",width/2,600);
          }else if(rekor<4){
          getin(2,"Helal lan ilk üçe girdin",width/2,600);
          }else{
          getin(2,"Tebrikler "+rekor+". sırayı kaptın",width/2,600);
          }
        if(sts[2]==255 && keyPressed){
          handylist[totalKey-1]=false;
          accesskey[totalKey-1]=false;
          gentle=1;
        }
        }
      }
      }

        break;

   case 1:
      background(0);
      geyepod="";
      if(sts[3]==255){
        for(int i=0;i<input.length;i++){
          nameter();
          geyepod+=input[i];
        }
      }
      textSize(65);
      getin(3,"Top 10 arasında nasıl anılmak istiyorsun:\n"+"\""+geyepod+"\"",width/2,height/2);
      
      if(sts[3]==255){textSize(40);text("Devam etmek için 'ENTER'e basınız.",width/2,900);}
      if(sts[3]==255&&key==ENTER){gentle=2;hs.addscore(Songs[sgk].getName().replace(".mp3",""),geyepod,score);}
  break;
  
  case 2:
    background(0);
    getin(4,"",0,0);
    higuys("sort");
    if(keyPressed&&sts[4]==255){window="menu";}
  break;
    }
}
    //
    
  
  
  
  
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

    
    fill(250);
    textFont(fontScore);
    textAlign(CENTER);
    text(score, width -350, 600);
    textSize(40);

  }
  
  
  void higuys(String mode){
    boolean passportation = false;
    PFont sk = createFont("Agency FB",50);
    textFont(sk);
    for(int f=0;f<10;f++){
      JSONObject theguy;
      String name = "";
      int skore =0;
      String aktarmalibelediyeotobusu = "";
     try{
       theguy = hs.data.getJSONObject(sgk).getJSONArray("siralama").getJSONObject(f);
       name = theguy.getString("name");
       skore = int(theguy.getFloat("score"));
       aktarmalibelediyeotobusu = str(skore);
     }catch(Exception ex){
       passportation = true;
     }
      if(mode=="sort"){
        if(f+1==rekor){fill(250,45,45);}else{fill(255);}
        text((f+1)+". "+name+"......("+aktarmalibelediyeotobusu+")",width/2,200+(75*f));
        
      }
      if(mode=="update"){
        if(score>skore){
          rekor=f+1;
          break;
        }
        if(f==9){
          fark = int(skore - score);
          break;
        }
      }
    }
  }
  
  
  
  void gotoskor(){
    alpha+=5;
    if(alpha>255){window="skor";}
    tint(255,alpha);
    dark.resize(0,2000);
    image(dark,width/2,height/2);
  }
  
  void nameter(){
    if(keyPressed){keylist[totalKey-1]=true;}else{keylist[totalKey-1]=false;}
    
    if(handylist[totalKey-1]){
        if(key == BACKSPACE){
            accesskey[totalKey-1]=false;
            handylist[totalKey-1]=false;
            input[entercet] = char(0);
            if(entercet!=0){entercet--;}
            
          }
        for(int i=0;i<25;i++){
          

          
          if(handylist[totalKey-1]&&key == i+97){
            accesskey[totalKey-1]=false;
            handylist[totalKey-1]=false;
            input[entercet] = char(97+i);
            if(entercet<9){entercet++;}
            
           
          }
          
        }
      
    }
  }
  
  void getin(int ci,String text,float x,float y){
    if(sts[ci]<255){sts[ci]+=5;}
    fill(sts[ci]);
    text(text,x,y);
  }

}
