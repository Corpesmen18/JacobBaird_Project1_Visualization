class SceneTitle {
  
  HUD hud = new HUD();
  
  void update(){
    hud.update();
  }
  
  void draw(){
    background(48);
    
    
    hud.draw();
  }
  
}
