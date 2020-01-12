class hiscore{
  String name;
  
  JSONArray data;
  
  File f;
  
  hiscore(){
  }
  
  
  


  void startup(){ //json dosyası yoksa oluşturuyor varsa açıyor
    f =  new File(dataPath("hiscores.json"));
    if(f.exists()){
      data = loadJSONArray("hiscores.json");
    }else{saveJSONArray(data, "data/hiscores.json");}
  }

  void addscore(String musicn, String guyname, int skor){
    startup();
    int islemno=1001;
     //data verisi içinde ufak bilgi kırıntıları varsa bunlar aradığımız şey mi bakıyoruz      Şarkı arıyosz
    for(int i=0;i<data.size();i++){
      
      if(musicn.equals(data.getJSONObject(i).getString("name"))){ // aradığımız şey mi kontrol ediyhoruz
        println("İşlem numarası atanyıor");
        islemno=i; // aradığımız şey ise işlem nosunu ayarlıyoruz
        break;
      }
    }
      println(islemno);
      if(islemno == 1001){ // işlem nosu, girilmediği takdirde 1001 olacağı için aranıp bulunamadığı anlaşılıyor 
        
        JSONObject sark = new JSONObject();
        JSONArray siralama = new JSONArray();
        siralama.setJSONObject(0,createchar(guyname,skor));
        sark.setString("name",musicn);
        sark.setJSONArray("siralama",siralama);
        data.setJSONObject(data.size(),sark);
      }else{
        JSONObject sark = data.getJSONObject(islemno);
        data.setJSONObject(islemno,sark.setJSONArray("siralama",nizam(sark.getJSONArray("siralama"),createchar(guyname,skor))));
      }
      saveJSONArray(data, "data/hiscores.json");
    
  }
  

  
  JSONArray nizam(JSONArray list,JSONObject newguy){
    JSONArray retlist = new JSONArray();
    list.setJSONObject(list.size(),newguy);
    FloatList forsort = new FloatList();
    for(int i=0;i<list.size();i++){
      forsort.append(list.getJSONObject(i).getFloat("score"));
    }
    forsort.sortReverse();
    if(forsort.size() > 10){forsort.remove(10);}
    
    for(int i=0;i<forsort.size();i++){
      for(int u=0;u<list.size();u++){
        if(forsort.get(i)==list.getJSONObject(u).getFloat("score")){ // burda bug oluşuyor ama üşendim :( ☻☻
        retlist.setJSONObject(i,list.getJSONObject(u));
        }
      }
    }
    
    return retlist;
  }

  JSONObject createchar(String nm,float skcore){
    JSONObject thatguy = new JSONObject();
    thatguy.setString("name",nm);
    thatguy.setFloat("score",skcore);
    return thatguy;
  }
  
  
  //  JSONArray showscore(){
      
  //}

}
