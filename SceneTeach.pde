class SceneTeach {
  
  HUD hud = new HUD();
  Textbox textbox = new Textbox(width/2, height - 100, 1200, 200, 16, "test test test test test test teste  ts est ets est ets est est ets est est es est ets ets est es est es dfsg sdf gs dfg sdf g sf g sdf g dsfg sdfgsdfgsdfg s dfg sdf \n" +
  "sda");
  int slide = 0;
  
  void update(){
    hud.update();
  }
  
  void draw(){
    background(128);
    
    switch(slide){
      case 0:
        fill(255, 0, 0);
        rect(width/2 - 50, height/2 - 50, 100, 100);
        break;
      case 1:
        fill(0, 255, 0);
        circle(width/2, height/2, 100);
        break;
      case 2:
        fill(0, 0, 255);
        triangle(width/2 - 50, height/2 + 50, width/2 + 50, height/2 + 50, width/2, height/2 - 50);
        break;
    }
    
    textbox.draw();
    hud.draw();
  }
  
  void Progress(){
    slide++;
    
    switch(slide){
     case 1:
       textbox.text = "wow";
       break;
     case 2:
      textbox.text = "this \n" +
      "is \n" +
      "so many \n" +
      "lines";
      break;
    }
    
    
  }
  
}
