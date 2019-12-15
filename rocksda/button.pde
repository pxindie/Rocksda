class button{
  float x = width/2;
  float ps; // büyüme değeri
  float mxs; // ana genişlik değeri
  float mys; // ana yükseklik değeri
  float mts;
  float xs; // genişlik değeri
  float ys; // yükseklik değeri
  float ts; // yazı boyutu değeri
  
  button(float x,float xs_,float ys_, float ts_){
    ps = x;
    mxs = xs_;
    mys = ys_;
    mts = ts_;
  }
  
  boolean buton(String text,float y,boolean sec,boolean pres){
    boolean ret = false; //return

    if(sec){
      xs = mxs+ps;
      ys = mys+ps;
      ts = mts+ps/2;
      strokeWeight(5);
      if(pres){ret = true;}
      
    }else{
      xs = mxs;
      ys = mys;
      ts = mts;
      strokeWeight(2);
    }
    
    rectMode(CENTER);
    fill(#747474);
    rect(x,y,xs,ys);
     
    textAlign(CENTER);
    textSize(ts);
    fill(0);
    text(text,x,y+10);
    return ret;
  }
  
  //float waver(float x){
  //  if(x>plusize)x--;
    
  //  return vac;
  //}
  
  
  
}
