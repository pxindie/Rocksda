class timer {
  float songtime;
  
  float systime;

  float bctime;
  
  float nowtime;
  
  float retvar;

  boolean workin = false;

  boolean countdown;
  timer(float songietime) {
    songtime = songietime;
  }
  
  
  float time() {
    work();
    return nowtime;}

  
  void work() {
    if(nowtime != songtime){
      if(!workin){bctime=(minute()*60000)  +  (second()*1000)  + millis();workin = true;}
        systime= (minute()*60000)  +  (second()*1000) + millis();
        nowtime = systime - bctime;
      }
    }
  
  float calc(int x){return float(nf(x*0.01,0,2).replace(",","."));}
  
  void showtime(){
    int minnak;
    int seccak;
    
    minnak = int(nowtime/60000);
    seccak = int(nowtime%60000);
    fill(#CECECE);
    if(nowtime == songtime){fill(#B40D0D);textSize(60);}
    PFont fontTime;
    fontTime = createFont("AgencyFB-Reg.vlw",100);
    textFont(fontTime);
    textAlign(CENTER);
    text(minnak+":"+seccak,width/2,150);
    
  
  }

}
