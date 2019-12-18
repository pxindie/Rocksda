class music{
  String name;
  int numNote = 400;
  float songtime;
  IntList atamalist = new IntList();
  

  FloatList raysira = new FloatList();

  
  notebar[] notes;
  
  void adjust(String name){
    raysira.clear();
    for(int i=0;i<numKey;i++){
      raysira.append(0);
    }
    
    soundload(name);
    songtime = sf.duration();
      
    
    notes = new notebar[numNote];
    clock = new timer(songtime);
    
    arrange(songtime);
    
  }
  
  
  
  void run(){
    for (notebar note : notes) {
        note.motor();
    }
  }
  
  

  void arrange(float stime){
    
    int id = 0;
    float tick = 0.5;
    
    for (float i = 0; i<stime; i+=tick) {
      println("----"+i+"----");
      println(atamalist);
      println(raysira);
      println("------------");
      range(numKey);
      
      for(int j =0;j<raysira.size();j++){
        if(raysira.get(j)>1){
          println("**********"+atamalist);
          for(int q=0;q<atamalist.size();q++){
            if(atamalist.get(q)==j){
              atamalist.remove(q);
            }
          }
          raysira.sub(j,tick);
        }
      }
        for(int u=0;u<int(random(numKey));u++){
          int rayrandom = int(random(numKey-1));
          

          
          if(atamalist.size()>0){
            int rand = int(random(atamalist.size()-1));
            
            int j = atamalist.get(rand);
            atamalist.remove(rand);
            raysira.set(j,rayrandom);
            
            notes[id] = new notebar(j, horPos(j, sutunWidth)+(sutunWidth/2), 1, hiz, i , notes, id, teamRenk[j], passin,rayrandom);
            println(id+":"+rayrandom);
            id++;
            if(id>=numNote){break;}
          }
        }
      
       if(id>=numNote){break;}
    }
    println("**************************************************************************************");
    //for(int d=id;d<numNote;d++){
    //   notes[id] = new notebar(0, 0, 1, 0, songtime+1 , notes, id, teamRenk[0], passin);
    //   println(id);
    //   id++;
    //}
  }
  
  
  
  void range(int x){
    atamalist.clear();
    for(int i=0;i<x;i++){
      atamalist.append(i);
    }
  }
  


}
