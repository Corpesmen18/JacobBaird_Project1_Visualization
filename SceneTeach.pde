class SceneTeach {
  
  ArrayList<Shape> shapes = new ArrayList();
  
  Shape sh;
  HUD hud = new HUD();
  Textbox textbox = new Textbox(width/2, height - 100, 1200, 200, 20, "Inheritance and Polymorphism are two interconnected programming concepts that relate heavily to Object Oriented Programming. \n" +
  "To understnd these concepts we should first get a general understanding of what Object Oriented Programming is.");
  int slide = 0;
  
  void update(){
    hud.update();
    
    for (Shape s : shapes){
      s.update();
    }
    
  }
  
  void draw(){
    background(128);
    
    for (Shape s : shapes){
      s.draw();
    }
    
    textbox.draw();
    hud.draw();
  }
  
  void Progress(){
    slide++;
    
    switch(slide){
     case 1:
       sh = new Shape(width/2, height/2, 50, 50, 255, 0, 0, "SQUARE", "Horizontal");
       shapes.add(sh);
       textbox.text = "Anything can be considered an object in programming. This square is an object and has various different properties and functions associated \n" +
       "with it such as the shape, color, and movement.";
       break;
     case 2:
       sh = new Shape(width/2 - 100, height/2, 50, 50, 0, 255, 0, "CIRCLE", "Vertical");
       shapes.add(sh);
       sh = new Shape(width/2 + 100, height/2, 50, 50, 0, 0, 255, "TRIANGLE", "Scale");
       shapes.add(sh);
       textbox.text = "These properties and functions can change between differnt versions of the same object. All of these shapes are objects form the same class \n" +
       "but they possess different properties. Inheritance and Polymorphism builds upon the diverse possibilities of objects by making it more \n" + "convenient to utilize";
       break;
     case 3:
       debug = true;
       sh = new Shape(width/2 - 50, height/2 - 100, 50, 50, 255, 0, 0, "CIRCLE", "Scale");
       shapes.add(sh);
       shapes.get(0).children.add(sh);
       sh = new Shape(width/2 + 50, height/2 - 100, 50, 50, 0, 0, 255, "SQUARE", "Vertical");
       shapes.add(sh);
       shapes.get(0).children.add(sh);
       textbox.text = "Inheritance allows us to make children of an object with either the same or different properties to it's parent.";
       break;
    }
    
    
  }
  
}
