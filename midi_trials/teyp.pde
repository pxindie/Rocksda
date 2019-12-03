class Player{
  int numkey;
  public void main(){
    Player player = new Player();
    player.setUpPlayer(numKey);
    
  }
  
  public void setUpPlayer(int numKey){
    try{
      Sequencer kasetcalar = MidiSystem.getSequencer();
      kasetcalar.open();

      
      Sequence kaset = new Sequence(Sequence.PPQ, 4);
       
      Track calgi = kaset.createTrack();
      
      for(int i = 5; i<(4*numkey);i +=4) {
        calgi.add(makeEvent(144,1,i,100,i));
        calgi.add(makeEvent(128,1,i,100,i+2));
      }
      
      kasetcalar.setSequence(kaset);
      kasetcalar.setTempoInBPM(200);
      
      kasetcalar.start();
      
      while(true){
        if(!kasetcalar.isRunning()){
          kasetcalar.close();
          exit();
        }
      }
    
    } catch(Exception ex) {}
  }
  public MidiEvent makeEvent(int command, int channel,int note, int velocity,int tick){
    MidiEvent event = null;
    
    try {
      ShortMessage a = new ShortMessage();
      a.setMessage(command,channel,note,velocity);
      
      event = new MidiEvent(a,tick);
      }
      catch(Exception ex){}
     return event; 
    }
  }
