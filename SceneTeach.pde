class SceneTeach {

  ArrayList<Shape> shapes = new ArrayList();
  Container c;

  Shape sh;
  HUD hud = new HUD();
  Textbox textbox = new Textbox(width/2, height - 100, 1200, 200, 30, "Inheritance and Polymorphism are two interconnected programming concepts that relate\n" + "heavily to Object Oriented Programming."
    + " To understnd these concepts we should first get a \ngeneral understanding of what Object Oriented Programming is.");
  int slide = 0;

  void update() {
    hud.update();

    for (Shape s : shapes) {
      s.update();
    }

    if (c != null) {
      c.update();
    }
  }

  void draw() {
    background(128);

    for (Shape s : shapes) {
      s.draw();
    }

    if (c != null) {
      c.draw();
    }

    textbox.draw();
    hud.draw();
  }

  void Progress() {
    slide++;

    switch(slide) {
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
        " but they possess different properties. Inheritance \nand Polymorphism builds upon the diverse possibilities of objects by making it more \nconvenient to utilize.";
      break;
    case 3:
      debug = true;
      sh = new Shape(width/2 - 50, height/2 - 100, 50, 50, 255, 0, 0, "SQUARE", "Horizontal");
      shapes.add(sh);
      shapes.get(0).children.add(sh);
      sh.parent = shapes.get(0);
      sh = new Shape(width/2 + 50, height/2 - 100, 50, 50, 255, 0, 0, "SQUARE", "Horizontal");
      shapes.add(sh);
      shapes.get(0).children.add(sh);
      sh.parent = shapes.get(0);
      textbox.text = "Inheritance allows us to make children of an object with either the same or different properties \nto it's parent. Both of these new Squares are " +
        "children of the square they're attached to and by \ndefault have the same properties as their parent.";
      break;
    case 4:
      sh = shapes.get(3);
      sh.iChangeShape("CIRCLE");
      sh.iChangeFunc("Scale");
      sh = shapes.get(4);
      sh.iChangeColor(0, 0, 255);
      sh.iChangeFunc("Vertical");
      textbox.text = "Polymorphism allows these children to also override the properties provided by their parents. \nThis allows them to be useful for quickly making modified" +
        " versions of existing objects that \nare intended to be used frequently.";
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
        "only inherited the changes to properties \nthey haven't overridden.";
      break;
    case 7:
      sh = shapes.get(3);
      sh.resetOverrides();
      textbox.text = "It's also easy for children to reset the overrides they have and return to inheriting those \nproperties from their parent. The left child has reset it's overrides" +
        " so now it will return to taking \non the same properties as it's parent.";
      break;
    case 8:
      c =  new Container(400, 50, 950, 200);
      textbox.text = "Arrays are also pretty important to the significance of polymorphism. Because polymorphism \nallows children of an object to all be recognized as the same type of object " +
      "when things like \narrays are trying to interact with them.";
      break;
    case 9:
      c.shapes.add(shapes.get(0));
      c.target = (shapes.get(0));
      textbox.text = "This an array made up of this parent object but even when we try to put objects that aren't \nof the same type like it's children into it...";
      break;
    case 10:
      c.shapes.add(shapes.get(3));
      c.shapes.add(shapes.get(4));
      textbox.text = "They both fit into it! Even though one of them is overriding it's parent and so has different \nproperties and functions!";
      break;
    case 11:
      dragging = null;
      shapes.get(1).x = 500;
      shapes.get(1).y = 100;
      shapes.get(2).x = 850;
      shapes.get(2).y = 100;
      textbox.text = "Yet when we try to put these other objects into the same array they are rejected!";
      break;
    case 12:
      c.target = shapes.get(4);
      c.shapes.remove(0);
      c.shapes.remove(0);
      textbox.text = "In a different array that is made for one of the children of this shape, neither the parent \nof that shape or the other children of that parent are accepted!";
      break;
    case 13:
      sh = shapes.get(4);
      Shape sa = new Shape(500, 100, sh.w, sh.h, sh.r, sh.g, sh.b, sh.shape, sh.func);
      shapes.add(sa);
      sh.children.add(sa);
      sa = new Shape(800, 100, sh.w, sh.h, sh.r, sh.g, sh.b, sh.shape, sh.func);
      shapes.add(sa);
      sh.children.add(sa);
      textbox.text = "However the children of that child are all accepted into the array without difficulties!";
      break;
    }
  }
}
