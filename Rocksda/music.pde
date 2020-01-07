

class music {
  int gevplus = 1000;
  String name;
  int inci;
  float milta;
  float milsec; //music kayıt yaparken time işlemiyor bu da kendi time sistemi için
  int Cdensity = 2;
  
  int numNote = 400;
  float songtime;
  
  XML[] xml = new XML[5];
  
  float[] sures = new float[numKey];


  FloatList raysira = new FloatList();
  IntList atamalist = new IntList();

  notebar[] notes;

  void adjust(int xa) {   

    inci = xa;
    soundload(); 
    songtime = sf[xa].duration();
    notes = new notebar[notenumber()];
    clock = new timer(songtime);
    arrange();
  }



  void run() {
    try{
      for (notebar note : notes) {
        note.motor();
      }
    }catch(Exception ex){}
  }



  void arrange() {
    milta =0;
    println("----arrange----");
    rayres();
    for(int t=0;t<numKey;t++){
      sures[t]=0;
    }
    println("milta : "+milta);
    int p = inci;
    int id = 0;
    milsec=0;
    int tel=0;
    
    XML[] mesars = xf[p].getChild("part").getChildren("measure");
    for (int i=0; i< mesars.length; i++) { // Bi bölüğü alıyoz
      XML[] noty = mesars[i].getChildren("note");
      int chomar=0;
      
      for (int l=0; l<noty.length; l++) { // bi notayı alıyoz

        
        boolean wait=false;
        boolean chord=false;
        boolean tie=false;
        
        String[] noteDet = noty[l].listChildren();
        for(int q=0;  q<noteDet.length  ;q++){// nota detayları
          if(noteDet[q]=="rest"){wait=true;}
          if(noteDet[q]=="chord"){chord=true;}
          if(noteDet[q]=="tie"){tie = true;}
        }
        
        if(chord){chomar++;}else{chomar=0;}
        
        float duration = (float(noty[l].getChild("duration").getContent()));
        //println("-----öncü-----");
        //println(atamalist);
        //println("milsec : " + milsec);
        raydizgin();
        //println("-----artçı-----");
        //println(atamalist);
        //println("milsec : " + milsec);
        
        if(!chord){  milsec+=duration;  } //<>//
        if((!wait)&&(chomar<Cdensity)){
          
          if(atamalist.size()>0){
            int lzmlk = int(random(atamalist.size()));
            tel = atamalist.get(lzmlk);
            //println("tel : "+tel);
            notes[id] = new notebar(id,tel, hiz, milsec, duration); //<>//
          
            //if(tie){ 
            //  notes[id-1].period = (milsec + duration) - notes[id-1].ctime;
            //  notes[id].dead=true;
            //}
            if(notes[id].rayli){ //<>//
            raysira.set(tel,duration+gevplus);
            }else{raysira.set(tel,duration);}
            id++;
          }
          

        }
        
      }
    }
    println("id : " + id);
    println("notes : " + notes.length);
    //cetekill();
    println("*----DONE----*");
  }

int notenumber(){ // tanımlamai için gereken kaç nota alacağını
    int number =0;
    milta =0;
    println("----notenumber----");
    rayres();
    for(int t=0;t<numKey;t++){
      sures[t]=0;
    }
    println("milta : "+milta);
    int p = inci;
    int id = 0;
    milsec=0;
    int tel=0;
    
    XML[] mesars = xf[p].getChild("part").getChildren("measure");
    for (int i=0; i< mesars.length; i++) { // Bi bölüğü alıyoz
      XML[] noty = mesars[i].getChildren("note");
      int chomar=0;
      
      for (int l=0; l<noty.length; l++) { // bi notayı alıyoz

        
        boolean wait=false;
        boolean chord=false;
        boolean tie=false;
        
        String[] noteDet = noty[l].listChildren();
        for(int q=0;  q<noteDet.length  ;q++){// nota detayları
          if(noteDet[q]=="rest"){wait=true;}
          if(noteDet[q]=="chord"){chord=true;}
          if(noteDet[q]=="tie"){tie = true;}
        }
        
        if(chord){chomar++;}else{chomar=0;}
        
        float duration = (float(noty[l].getChild("duration").getContent()));
        //println("-----öncü-----");
        //println(atamalist);
        //println("milsec : " + milsec);
        raydizgin();
        //println("-----artçı-----");
        //println(atamalist);
        //println("milsec : " + milsec);
        
        if(!chord){  milsec+=duration;  }
        if((!wait)&&(chomar<Cdensity)){
          
          if(atamalist.size()>0){
            int lzmlk = int(random(atamalist.size()));
            tel = atamalist.get(lzmlk);
            //println("tel : "+tel);
            number++;
            if(duration>perlimit){
              raysira.set(tel,duration+gevplus);
            }else{raysira.set(tel,duration);}
            id++;
          }
          //if(tie){ 
          //    notes[id-1].period = (milsec + duration) - notes[id-1].ctime;
          //    duration = (milsec + duration) - notes[id-1].ctime;
          //    notes[id].dead=true;
          //    raysira.set(notes[id-1].sutun,duration+300);
              
          //  }else{raysira.set(tel,duration+300);}
          
        }
        
      }
    }
    println("id : " + id);
    println("notes : " + number);
    //cetekill();
    return number;
}


  void range(int x) {
    atamalist.clear();
    for (int i=0; i<x; i++) {
      atamalist.append(i);
    }
  }

  void raydizgin(){
    atamalist.clear();
    for(int j =0;j<raysira.size();j++){
      if(raysira.get(j)>0){
        raysira.sub(j,(milsec-milta));
      }
      if(raysira.get(j)<=0){raysira.set(j,0);atamalist.append(j);/*println("evet eksiye düşebiliyor muş");*/}
    }
    atamalist.sort();
    milta = milsec;
  }
  
  void cetekill(){  //
    for(int z=0;z<notes.length;z++){
     float sub = notes[z].ctime - sures[notes[z].sutun];
     if(sub<=100){notes[z].dead=true;}else{sures[notes[z].sutun]=notes[z].ctime;}
    }
  }

  void rayres(){
      raysira.clear();
    for (int i=0; i<numKey; i++) {
      raysira.append(0);
    }
  }

}
