

class music{
  String name;
  int numNote = 200;
  float songtime;
  IntList atamalist = new IntList();
  
  notebar[] notes;
  
  void adjust(String name){
    soundload(name);
    songtime = sf.duration();
      
    
    notes = new notebar[numNote];
    clock = new timer(songtime);
    
    arrange(songtime);
    
  }
  
  
  
  void run(){
    for (notebar note : notes) {
        note.motor(time);
    }
  }
  
  

  void arrange(float stime){
    
    int id = 0;
    
    for (int i = 0; i<stime; i++) {
      println(0);
      range(numKey);
        for(int u=0;u<int(random(numKey));u++){
          
          int rand = int(random(atamalist.size()));
          
          int j = atamalist.get(rand);
          atamalist.remove(rand);
            
          notes[id] = new notebar(j, horPos(j, sutunWidth)+(sutunWidth/2), 1, hiz, i , notes, id, teamRenk[j], passin);
          println(id);
          id++;
          if(id>=numNote){break;}
          println("AA");
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
