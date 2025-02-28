class SceneSandbox {
  
  float x1, y1, x2, y2;
  ArrayList<Shape> shapes = new ArrayList();
  ArrayList<Container> boxes = new ArrayList();
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
        lastAction = "Container";
      }
      
    }
    
    switch (lastAction) {
       case "default":
         text.text = "Interact with the shapes and buttons to learn more about inheritance and polymorphism!";
         break;
       case "New object":
         text.text = "Any object can become the parent of many different or similar objects!";
         break;
       case "Inherited change":
         text.text = "Changing the property of a parent will change the same property on all it's children if they \nhaven't overridden it!";
         break;
       case "New child":
         text.text = "When making a new child it will immediatley inherit all the properties of it's parent!";
         break;
       case "Override":
         text.text = "Changing the properties of a child will override the properties inherited from the parent and \nfurther changes to that property of the parent will no longer " + 
         "affect the child!";
         break;
       case "Container":
         text.text = "Arrays can contain many different objects of the same type!";
         break;
       case "Shape in container":
         text.text = "Arrays can only hold objects of the same type and it's children!";
         break;
       case "Child in container":
         text.text = "Even children of an object can go into an array meant to hold it's parent!";
         break;
       case "Overridden child":
         text.text = "Even if the child has overridden functions or properties the array will still accept it!";
         break;
       case "Rejected":
         text.text = "An array can't contain objects of a different type or the parents of it's type!";
         break;
       case "Reset Overrides":
           text.text = "Removing the overrides of a child will let it return to inheriting those properties from it's parent!";
         break;
       case "No Parent":
         text.text = "This shape has no parent and so doesn't have any overrides to rest!";
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
