class timer {
  float songtime;
  
  float systime;

  float bctime;
  
  float nowtime;
  
  float retvar;

  boolean workin = false;

  timer(float songietime) {
    songtime = songietime;
  }
  
  
  float time() {
    work();
 
    return nowtime;}

  
  void work() {
    if(nowtime != songtime){
      if(!workin){bctime=(minute()*60)+second();workin = true;}
        systime= minute()*60+second();
        nowtime = systime - bctime;
      }
    }
  
  float calc(int x){return float(nf(x*0.01,0,2).replace(",","."));}
  
  void showtime(float x){
    int minnak;
    int seccak;
    
    minnak = int(nowtime/60);
    seccak = int(nowtime%60);
    fill(#CECECE);
    if(nowtime == songtime){fill(#B40D0D);textSize(60);}
    PFont fontTime;
    fontTime = createFont("AgencyFB-Reg.vlw",100);
    textFont(fontTime);
    textAlign(CENTER);
    text(minnak+":"+seccak,width/2,150);
    
  
  }

}
