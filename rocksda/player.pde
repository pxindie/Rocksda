import java.util.concurrent.ConcurrentHashMap;

class player implements Receiver {
  Sequencer ardisimci;
  Sequence ardis;
  Transmitter fm;
  
  ConcurrentHashMap<Integer, Note> midiData = new ConcurrentHashMap<Integer, Note>();
  
  public void load(String name) {
    File midF = new File(dataPath(name+".mid"));
    try{
      ardisimci = MidiSystem.getSequencer();
      ardisimci.open();
      fm = ardisimci.getTransmitter();
      fm.setReceiver(this);
      ardis = MidiSystem.getSequence(midF);
      
    }catch(Exception e){}
  }
  
  public void start(){
    ardisimci.start();
  }
  
  @Override public void send(MidiMessage message,long t){
    if(message instanceof ShortMessage) {
    ShortMessage sm = (ShortMessage) message;
    int cmd = sm.getCommand();
    if(cmd == ShortMessage.NOTE_ON || cmd == ShortMessage.NOTE_OFF){
      int channel = sm.getChannel() -1;
      int note = sm.getData1();
      int velocity = sm.getData2();
      int id = channel *1000 + note;
    }
    
    }
  
  }

  @Override public void close(){}
}
