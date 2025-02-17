class SceneTitle {
  
  HUD hud = new HUD();
  
  void update(){
    hud.update();
  }
  
  void draw(){
    background(128);
    
    
    hud.draw();
  }
  
}
