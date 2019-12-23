

class music {
  String name;
  int inci;
  float milta=time;
  
  int Cdensity = 1;
  
  int numNote = 400;
  float songtime;
  
  XML[] xml = new XML[5];

  FloatList raysira = new FloatList();
  IntList atamalist = new IntList();

  notebar[] notes;

  void adjust(int xa) {   
    raysira.clear();
    for (int i=0; i<numKey; i++) {
      raysira.append(0);
    }
    inci = xa;
    soundload(); 
    songtime = sf[xa].duration();
    notes = new notebar[notenumber()];
    println(notenumber());
    clock = new timer(songtime);
    arrange();
  }



  void run() {
    for (notebar note : notes) {
      note.motor();
    }
  }



  void arrange() {
    int p = inci;
    int id = 0;
    float milsec=0;
    int tel=0;
    
    XML[] mesars = xf[p].getChild("part").getChildren("measure");
    for (int i=0; i< mesars.length; i++) { // Bi bölüğü alıyoz
      XML[] noty = mesars[i].getChildren("note");
      int chomar=0;
      
      for (int l=0; l<noty.length; l++) { // bi notayı alıyoz
        range(numKey);
        raydizgin();
        boolean wait=false;
        boolean chord=false;
        boolean tie=false;
        //println(raysira);
        String[] noteDet = noty[l].listChildren();
        for(int q=0;  q<noteDet.length  ;q++){// nota detayları
          if(noteDet[q]=="rest"){wait=true;}
          if(noteDet[q]=="chord"){chord=true;}
          if(noteDet[q]=="tie"){tie = true;}
        }
        
        if(chord){chomar++;}else{chomar=0;}
        
        float duration = (float(noty[l].getChild("duration").getContent()));
        
        
        
        
        if(!chord){  milsec+=duration;  }
        if((!wait)&&(chomar<Cdensity)){
          
          if(atamalist.size()>0){
            int lzmlk = int(random(atamalist.size()));
            tel = atamalist.get(lzmlk);
            atamalist.remove(lzmlk);
          }else{tel = -1;}
         
          notes[id] = new notebar(id,tel, hiz, milsec+500, duration);
          
          if(tie){ 
            notes[id-1].period = (milsec + duration) - notes[id-1].ctime;
            notes[id].dead=true;
          }
            id++;
          if(duration<300){duration=320;}
          raysira.set(tel,duration);
        }
        
      }
    }
    
    cetekill();
    println("*----DONE----*"+notes.length);
  }

int notenumber(){
  int number=0;
  
  XML[] mess = (xf[inci].getChild("part").getChildren("measure"));
  for (int i=0; i< mess.length; i++) { // Bölüklere ayırdık
      int numchor=0;
      XML[] notil = mess[i].getChildren("note");
      for (int b=0; b<notil.length; b++) { // Notaları ayıkladık
        
        String[] noteDet = notil[b].listChildren();
        
        boolean rest=false;
        boolean chor=false;
        
        for(int q=0;  q<noteDet.length  ;q++){// Notanın niteliklerini ayıklıyor
          if(noteDet[q]=="rest"){rest=true;}
          if(noteDet[q]=="chord"){chor=true;}
        }
        
        if(!rest){
          if(chor){  numchor++;  }else{  numchor=0;  }
          if(numchor<Cdensity){  number++;  }
        }
        
      }
    }
    println(number);
  return number;
}


  void range(int x) {
    atamalist.clear();
    for (int i=0; i<x; i++) {
      atamalist.append(i);
    }
  }

  void raydizgin(){
    for(int j =0;j<raysira.size();j++){
        if(raysira.get(j)!=0){
          for(int q=0;q<atamalist.size();q++){
            if(atamalist.get(q)==raysira.get(j)){
              atamalist.remove(q);
            }
          }
          
          raysira.sub(j,(time-milta));
          if(raysira.get(j)<0){raysira.set(j,0);}
          
        }
    }
    milta = time;
  }
  
  void cetekill(){  
    float[] sures = new float[numKey];
    for(int t=0;t<numKey;t++){
      sures[t]=0;
    }
    for(int z=0;z<notes.length;z++){
     float sub = notes[z].ctime - sures[notes[z].sutun];
     if(sub<500){notes[z].dead=true;}else{sures[notes[z].sutun]=notes[z].ctime;}
    }
  
  }

}
