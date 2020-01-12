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
    if(3*1000>nowtime){
      if(!workin){bctime=millis();workin = true;}
        systime= millis();
        nowtime = systime - bctime;
      }else{msc.end = true;}
    }
  
  float calc(int x){return float(nf(x*0.01,0,2).replace(",","."));}
  
  
  
  void showtime(){
    String minnak;
    String seccak;
    float notik = nowtime/1000;
    minnak = nf(int(notik/60),2,0);
    seccak = nf(int(notik%60),2,0);
    fill(225);
    if(nowtime == songtime){fill(#B40D0D);textSize(60);}


    textFont(fontTime);
    textAlign(CENTER);
    text(minnak+":"+seccak,width/2,90);
    
  
  }

}
