class button{
  float x = width/2;
  float ps; // büyüme değeri
  float mxs; // ana genişlik değeri
  float mys; // ana yükseklik değeri
  float mts;
  float xs; // genişlik değeri
  float ys; // yükseklik değeri
  float ts; // yazı boyutu değeri
  
  float quadx; 
  float quadx_; 
  float quady;
  float quady_;
  
  float xpl=600;
  float ypl=120;

  int yassir =120; // genişleme şeysi
  int alpha=160;
  
  int ekpanel =0;
  button(float x,float y){
    quadx = x;
    quady = y;
    quadx_ = quadx+xpl;
    quady_ = quady+ypl;
    
  }
  
  boolean panelon=false;
  
  boolean buton(boolean sec,boolean pres){
    boolean ret = false; //return
    
      if(sec){
        if(pres){ret = true;} 
      }
      return ret;
    
  }
  
   boolean imgbuton(String text,boolean sec,boolean pres,int huey){
    boolean ret = false; //return

      
      if(sec){
        if(pres){
          ekpanel++;
          handylist[2]=false;
          accesskey[2]=false;
          }
          if(alpha <= 210){alpha+=15;}
          
          if(ekpanel == 1){
            if(quady_<quady+300){quady_+=20;panelon=false;}else{panelon=true;}
            

            
          }
          if(ekpanel == 2){
            ekpanel =0;
            ret = true;
          }
      }else{  
        ekpanel =0;
        if(quady_>quady+120){quady_-=20;}
        
        
        if(alpha >= 150){alpha-=15;}
        //if(quady_>quady+120){quady_-=25;}
      }

        noStroke();
        
        fill(0,0,0,alpha);
        quad(quadx,quady,  quadx_,quady,  quadx_-50,quady_,  quadx-50,quady_);
         
        textAlign(CENTER);
        textFont(fondy);
        fill(255,255,255,alpha+40);
        text(text,quadx+xpl/2,quady+ypl/2+15);
        
        if(panelon&&ekpanel==1){
          textSize(20);
          textAlign(CORNER);
          fill(255);
          text("Süre : "+int(sf[huey].duration())+"sn",quadx+25,quady+100);
          
          for(int f=0;f<10;f++){
           try{
             JSONObject theguy = hs.data.getJSONObject(huey).getJSONArray("siralama").getJSONObject(f);
           
             text((f+1)+"."+theguy.getString("name")+"("+theguy.getFloat("score")+")",quadx+20,quady+(25*f)+150);
           }catch(Exception ex){
             //println(ex);
             float xikab=0;
             int cezve =0;
             if(f<5){xikab = quadx+20;cezve=f;}else{xikab = quadx+300;cezve=f-5;}
             text((f+1)+".",xikab,quady+(25*cezve)+150);
           }
          }
        }
      return ret;
    
  } 

  
  
  
}
