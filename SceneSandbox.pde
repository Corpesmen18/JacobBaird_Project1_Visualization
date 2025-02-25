class SceneSandbox {
  
  float x1, y1, x2, y2;
  ArrayList<Shape> shapes = new ArrayList();
  ArrayList<Container> boxes = new ArrayList();
  String lastAction = "default";
  boolean drawing = false;
  boolean draw2 = false;
  Container drag;
  Container c;
  
  HUD hud = new HUD();
  Textbox text = new Textbox(width/2, height - 75, 1280, 150, 30, " ");
  Textbox left = new Textbox(75, height/2 - 75, 150, 570, 16, " ");
  Textbox right = new Textbox(width - 75, height/2 - 75, 150, 570, 16, " ");
  Textbox top = new Textbox(width/2, -100, 1280, 200, 20, "  ");
  
  void update(){
    text.update();
    left.update();
    right.update();
    top.update();
    
    for(int i = 0; i < shapes.size(); i++){
      Shape s = shapes.get(i);
      s.update();
    }
    
    for (Container b : boxes){
      b.update();
    }
    
    if(dragging != null){
      dragging.x = mouseX;
      dragging.y = mouseY;
    }
    
    if(drag != null){
      drag.px = drag.x;
      drag.py = drag.y;
      drag.x = mouseX;
      drag.y = mouseY;
      for(Shape s : drag.shapes){
        s.x += drag.x - drag.px;
        s.y += drag.y - drag.py;
      }
    }
    
    if(drawing){
      if(Mouse.onDown(Mouse.LEFT)){
        x1 = mouseX;
        y1 = mouseY;
        draw2 = true;
      }
      if(Mouse.onUp(Mouse.LEFT) && draw2){
        x2 = mouseX;
        y2 = mouseY;
        c = new Container(x1, y1, x2, y2);
        boxes.add(c);
        drawing = false;
        draw2 = false;
      }
      
    }
    
    switch (lastAction) {
       case "default":
         text.text = "Interact with the shapes and buttons to learn more about inheritance and polymorphism!";
         break;
      
      
    }
    
    hud.update();
  }
  
  void draw(){
    background(128);
    
    for(int i = 0; i < shapes.size(); i++){
      Shape s = shapes.get(i);
      s.draw();
    }
    
    for (Container b : boxes){
      b.draw();
    }
    
    text.draw();
    left.draw();
    right.draw();
    top.draw();
    hud.draw();
  }
  
}
