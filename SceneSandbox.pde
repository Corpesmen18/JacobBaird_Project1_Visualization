class SceneSandbox {
  
  ArrayList<Shape> shapes = new ArrayList();
  String lastAction = "default";
  boolean debug = false;
  Shape dragging;
  
  HUD hud = new HUD();
  Textbox text = new Textbox(width/2, height - 75, 1280, 150, 20, " ");
  Textbox left = new Textbox(75, height/2 - 75, 150, 570, 16, " ");
  Textbox right = new Textbox(width - 75, height/2 - 75, 150, 570, 16, " ");
  
  void update(){
    hud.update();
    
    for(int i = 0; i < shapes.size(); i++){
      Shape s = shapes.get(i);
      s.update();
    }
    
    if(dragging != null){
      dragging.x = mouseX;
      dragging.y = mouseY;
    }
    
    switch (lastAction) {
       case "default":
         text.text = "Interact with the shapes and buttons to learn more about inheritance and polymorphism!";
         break;
      
      
    }
    
  }
  
  void draw(){
    background(128);
    
    for(int i = 0; i < shapes.size(); i++){
      Shape s = shapes.get(i);
      s.draw();
    }
    
    text.draw();
    left.draw();
    right.draw();
    hud.draw();
  }
  
}
