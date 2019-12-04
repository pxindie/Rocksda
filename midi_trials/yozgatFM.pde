void setup() {
  int numkey = 4;
  Player player = new Player();
  player.setUpPlayer(numKey);
    
}

void draw() {
  
}

 
void keyPressed() {
  for (int i = 0; i<numkey; i++) {
    if (key == 49+i) {setUpPlayer(i);}
  }
}



void setUpPlayer(int u){
  try{
      // Kasetçalar tanımlanır
      Sequencer kasetcalar = MidiSystem.getSequencer();
      
      // Kaset kapağı açılıyor
      kasetcalar.open();

      // kaset tanımlanıyor
      Sequence kaset = new Sequence(Sequence.PPQ, 4);
      
      // Kasete enstrüman kaydediliyor
      Track calgi = kaset.createTrack();
      
      // Enstrümanlara görevler veriliyor
      for(int i = 5; i<4;i +=4) {
        calgi.add(makeEvent(144,1,i+u,100,i));
        calgi.add(makeEvent(128,1,i+u,100,i+2));
      }

      // Kaset takılıyor
      kasetcalar.setSequence(kaset);
      // Tempo ayarı yapılıyor
      kasetcalar.setTempoInBPM(200);
      
      // Oynat Tuşu
      kasetcalar.start();
      
      // Müzik bittiyse kaset çaları kapatıyor
      while(true){
        if(!kasetcalar.isRunning()){
          kasetcalar.close();
          exit();
        }
      }
    
    } catch(Exception ex) {}
  }


// Enstrümanlara verilen görev burda ayarlanıyor
MidiEvent makeEvent(int command, int channel,int note, int velocity,int tick){
    // Önce bi temizliyor
    MidiEvent event = null;
    
    try {
      // Görevler kağıda yazılıyor
      ShortMessage a = new ShortMessage();
      a.setMessage(command,channel,note,velocity);
      
      // Kağıda yazılanlar derlenip temize çekiliyor
      event = new MidiEvent(a,tick);
      }catch(Exception ex){}
      // Temize çekilen görev geri gönderiliyor
      return event; 
    }
