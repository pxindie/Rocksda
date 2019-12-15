class notebar {
  
  int channel;
  int note;
  int velocity;
  
  
  int y;
  int type;
  float x;
  int sutun;
  color renk;
  PVector location;
  PVector hizvec;
  
  int hiz;
  float ctime;
  int id;
  boolean turn = false; 
   
  boolean kontak=false; //sahneye çıkınca durmaması için (giriş vakti tek, diğer vakitlerde de hareket edebilmesi için)
  
  notebar[] others;
  
  notebar(int sutun_,float x_ ,int tip, int hiz_, float sira_,notebar[] oin,int idin,color renk_,int y_) {
    sutun = sutun_;
    x = x_;
    type = tip;
    hiz = hiz_;
    ctime = sira_;
    others = oin;
    id = idin;
    renk = renk_;
    y = y_;
    
    location = new PVector(x_, y_);
    hizvec = new PVector(0, hiz);
  }

  // Alpha
  PVector loca() {return location;}
  int team() {return sutun;}
  boolean life() {return type!=0;}
  
  //boolean check() {
  //  boolean var = false;
  //    if(kontak){
  //    var = true;
  //    for(int i = 0;i<others.length;i++){
  //      if (others[i].kontak){
  //        if (others[i].ctime<ctime){var = false;}
  //      }
  //    }}
  //  return var;
  //}
   
  void motor(float time) {
    if (type != 0) {
      if(time == ctime) {kontak = true;}
      if(kontak){
        update();
        display();
      }}}
  
  void kill(){
    kontak = false;
    turn = false;
    type =0;
    location.x = 2000;
  }
  
  void display() {
    
    fill(renk);
    if(id==1){fill(0);}
    strokeWeight(5);
    circle(location.x, location.y, 100);
    strokeWeight(1);
   
  }
  
  

  void update() {
    location.add(hizvec);
  }
  }
