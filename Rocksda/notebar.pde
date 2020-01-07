class notebar {
  
  int channel;
  int note;
  int velocity;
  
  float selfskor=0;
  
  
  float y;
  float x;
  float dia =100;
  boolean des1 =false;
  boolean des2 = false;
  int sutun;
  PVector location;
  PVector hizvec;
  
  float period;
  boolean dead;
  int hiz;
  float ctime;
  int id;
  boolean turn = false; 
  
  
  boolean detruc =false;
  
  // Raylılar için değişken alanı
  float raY;
  float raT;
  boolean rayli; // notebarın tipini belirlemek için
  boolean rayda = false; // raylı notebara basılıyor mu
  
  boolean kontak=false; //sahneye çıkınca durmaması için (giriş vakti tek, diğer vakitlerde de hareket edebilmesi için)
  
  notebar[] others;
  
  notebar(int idin ,int sutun_, int hiz_, float sira_, float peri/*duraqtion*/) {
    sutun = sutun_;


    x = horPos(sutun, sutunWidth)+(sutunWidth/2);
    
    hiz = hiz_;
    ctime = sira_;
    id = idin;
    y = passin;
    period = peri-300;
    
    location = new PVector(x, y);
    hizvec = new PVector(0, hiz);
    
    raT = ctime + peri;
    rayli = peri>perlimit?  true:false;
  }


  void motor() {
      if(!dead){
        if(clock.time() >= ctime) {kontak = true;}
        if(kontak){
          update();
          Display();
        }
        if(detruc){destruction();}
      }

  }
 
  void Display() {
    if(rayli){
      line(0,raY,1000,raY);
      stroke(reng(sutun,-30,220));
      strokeWeight(30);
      line(x, location.y, x, raY);
      stroke(reng(sutun,0,200));
      strokeWeight(15);
      line(x, location.y, x, raY+10);
    }
      fill(reng(sutun,-10,220));
      stroke(reng(sutun,-60,170));
      strokeWeight(10);
      circle(location.x, location.y, dia);
  }
 
 
 
    void kill(){
      accesskey[sutun] = false;
      handylist[sutun] = false;
      dead = true;
      kontak = false;
      turn = false;
      location.x = 2000;
  }
  

  void update() {
    if(turn){
      if (location.y>passout) {scoreC = -25;  score -= 25;  kill();}// kaçanı vuruyoz     
      
      if (handylist[sutun]) {
        if(!rayli){
          skorhesap();
          detruc=true;
        }else{
          skorhesap();
          if(raY>=location.y-90){
            detruc=true;
          }
        }
    }
   }
    
    if(rayli){
      if(handylist[sutun]&&turn){  hizvec.y=0; }
      
      if(hizvec.y == 0 &&!handylist[sutun]&&kontak){
        detruc=true;
        scoreC = -25;
        score -= 25;
      }
      
      if(clock.time() >= raT){raY += hiz;} else { raY = passin;}
      location.add(hizvec);
    
    }else{location.add(hizvec);}
  }
  
  void skorhesap(){
  fill(#08C909);
  textSize(40);
  textAlign(CENTER);
  fark = abs((passout-100) - location.y);
  if(!rayli){
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
  }else{
    if (fark>150) {
      score-=25;
      scoreC-=25;
      kill();
    } else if (fark>15) {
      score +=3;
      selfskor+=3;
      scoreC = 3;
    } else {
      score +=5;
      selfskor+=5;
      scoreC = 5;
      
      
    }
  }
 }
  void destruction(){
    hizvec.y=0;
    if(!des1){dia+=7;}else{dia-=7;}
    if(dia>=120){des1=true;}
    if(75>=dia){kill();}
  }
  

}
