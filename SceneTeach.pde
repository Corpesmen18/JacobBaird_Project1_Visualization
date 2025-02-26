class SceneTeach {
  
  ArrayList<Shape> shapes = new ArrayList();
  
  Shape sh;
  HUD hud = new HUD();
  Textbox textbox = new Textbox(width/2, height - 100, 1200, 200, 30, "Inheritance and Polymorphism are two interconnected programming concepts that relate\n" + "heavily to Object Oriented Programming." 
  + "To understnd these concepts we should first get a \ngeneral understanding of what Object Oriented Programming is.");
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
       textbox.text = "Anything can be considered an object in programming. This square is an object and has \nvarious different properties and functions associated" +
       "with it such as the shape, color, and \nmovement.";
       break;
     case 2:
       sh = new Shape(width/2 - 100, height/2, 50, 50, 0, 255, 0, "CIRCLE", "Vertical");
       shapes.add(sh);
       sh = new Shape(width/2 + 100, height/2, 50, 50, 0, 0, 255, "TRIANGLE", "Scale");
       shapes.add(sh);
       textbox.text = "These properties and functions can change between differnt versions of the same object. All of \nthese shapes are objects form the same class" +
       "but they possess different properties. Inheritance \nand Polymorphism builds upon the diverse possibilities of objects by making it more \nconvenient to utilize";
       break;
     case 3:
       debug = true;
       sh = new Shape(width/2 - 50, height/2 - 100, 50, 50, 255, 0, 0, "SQUARE", "Horizontal");
       shapes.add(sh);
       shapes.get(0).children.add(sh);
       sh = new Shape(width/2 + 50, height/2 - 100, 50, 50, 255, 0, 0, "SQUARE", "Horizontal");
       shapes.add(sh);
       shapes.get(0).children.add(sh);
       textbox.text = "Inheritance allows us to make children of an object with either the same or different properties \nto it's parent. Both of these new Squares are" + 
       "children of the square they're attached to and by \ndefault have the same properties as their parent";
       break;
     case 4:
       sh = shapes.get(3);
       sh.iChangeShape("CIRCLE");
       sh.iChangeFunc("Scale");
       sh = shapes.get(4);
       sh.iChangeColor(0, 0, 255);
       sh.iChangeFunc("Vertical");
       textbox.text = "Polymorphism allows these children to also override the properties provided by their parents. \nThis allows them to be useful for quickly making modified" + 
       " versions of existing objects that \nare intended to used frequently";
       break;
     case 5:
       sh = shapes.get(0);
       sh.iChangeShape("TRIANGLE");
       sh.iChangeColor(0, 255, 0);
       textbox.text = "Inheritance also allows the quick modification of the parent and all it's children by simply \nmodifying the parent. The parent of these shapes has changed both" +
       " it's shape and color and the \nchildren reflect some of those changes. But why not all of them? This has to do with \npolymorphism.";
       break;
     case 6:
       textbox.text = "If a child of an object has overridden a property of the parent than any changes the parent \nmakes to this aspect will not affect that child. In this case one of " +
       "the children has overridden the \nshape of the parent while the other has overridden the color but both have overridden the \nmovement of the parent. Since that is the case they " +
       "only inherited the changes to properties \nthey haven't overridden";
       break;
    }
    
    
  }
  
}
