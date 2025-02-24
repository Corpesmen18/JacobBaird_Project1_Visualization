class HUD {
  
  ArrayList<Button> buttons = new ArrayList();
  String extend = "default";
  Shape s;
  
  HUD() {
    
    Button sandbox = new Button(width/2 - 150, height/2, "SANDBOX", true, true, false, false);
    buttons.add(sandbox);
    Button teach = new Button(width/2 + 150, height/2, "TEACH", true, true, false, false);
    buttons.add(teach);
    Button next = new Button(width - 100, height - 250, "NEXT", false, false, false, true);
    buttons.add(next);
    Button title = new Button(225, 35, "MENU", false, false, true, true);
    buttons.add(title);
    Button debug = new Button(width - 225, height - 190, "DEBUG", false, false, true, false);
    buttons.add(debug);
    
    // sandbox menu right buttons
    Button shape = new Button(width - 75, 35, "New Shape", false, false, true, false);
    buttons.add(shape);
    Button child = new Button(width - 75, 95, "New Child", false, false, true, false);
    buttons.add(child);
    Button container = new Button(width - 75, 155, "New Container", false, false, true, false);
    buttons.add(container);
    //snadbox new shapes
    Button square = new Button(width - 225, 35, "Square", false, false, true, false);
    shape.buttons.add(square);
    Button circle = new Button(width - 225, 95, "Circle", false, false, true, false);
    shape.buttons.add(circle);
    Button triangle = new Button(width - 225, 155, "Triangle", false, false, true, false);
    shape.buttons.add(triangle);
    
    
    // sandbox menu left buttons
    Button cShape = new Button(75, 35, "Change Shape", false, false, true, false);
    buttons.add(cShape);
    Button cColor = new Button(75, 95, "Change Color", false, false, true, false);
    buttons.add(cColor);
    Button cFunction = new Button(75, 155, "Change\nFunction", false, false, true, false);
    buttons.add(cFunction);
    // sandbox change shape
    Button toSquare = new Button(225, 95, "To Square", false, false, true, false);
    cShape.buttons.add(toSquare);
    Button toCircle = new Button(225, 155, "To Circle", false, false, true, false);
    cShape.buttons.add(toCircle);
    Button toTriangle = new Button(225, 215, "To Triangle", false, false, true, false);
    cShape.buttons.add(toTriangle);
    // sandbox change color
    Button red = new Button(225, 95, "Red", false, false, true, false);
    cColor.buttons.add(red);
    Button blue = new Button(225, 155, "Blue", false, false, true, false);
    cColor.buttons.add(blue);
    Button green = new Button(225, 215, "Green", false, false, true, false);
    cColor.buttons.add(green);
    // sandbox change function
    Button horizontal = new Button(225, 95, "Horizontal", false, false, true, false);
    cFunction.buttons.add(horizontal);
    Button vertical = new Button(225, 155, "Vertical", false, false, true, false);
    cFunction.buttons.add(vertical);
    Button scale = new Button(225, 215, "Scale", false, false, true, false);
    cFunction.buttons.add(scale);
    
  }
  
  void update(){
    
    for (int i = 0; i < buttons.size(); i++) {
      Button b = buttons.get(i);
      b.update();
      if (b.title){
        if(sceneTitle != null){
          b.isVisible = true;
        } else b.isVisible = false;
      }
      if(b.sand){
        if(sceneSandbox != null){
          b.isVisible = true;
        } else if (!b.sand) b.isVisible = false;
      }
      if(b.teach){
        if(sceneTeach != null){
          b.isVisible = true;
        } else if (!b.teach) b.isVisible = false;
      }
      
      if(b.isClicked()){
        
        switch(b.buttonName){
          case "SANDBOX":
            if(b.isVisible){
              extend = "default";
              switchToSandbox();
            }
            break;
          case "TEACH":
            if(b.isVisible){
              extend = "default";
              switchToTeach();
            }
            break;
          case "NEXT":
            if(b.isVisible){
              extend = "default";
              sceneTeach.Progress();
            }
            break;
          case "MENU":
            if(b.isVisible){
              extend = "default";
              switchToTitle();
            }
            break;
          case "DEBUG":
            if(b.isVisible){
              extend = "default";
              sceneSandbox.debug = !sceneSandbox.debug;
            }
            break;
          case "New Child":
            if (b.isVisible){
              extend = "default";
              if(selected != null){
                s = new Shape(mouseX, mouseY, selected.w, selected.h, selected.r, selected.g, selected.b, selected.shape, selected.func);
                sceneSandbox.dragging = s;
                selected.children.add(s);
                sceneSandbox.shapes.add(s);
              }
            }
            break;
          case "New Container":
            if(b.isVisible){
              extend = "default";
              sceneSandbox.drawing = true;
            }
            break;
          case "New Shape":
          case "Change Color":
          case "Change Shape":
          case "Change\nFunction":
            if (b.isVisible){
              extend = b.buttonName;
            }
            break;
        }
      }
      if (b.buttonName == extend){
        for (Button e : b.buttons){
          e.isVisible = true;
          e.update();
          
          if (e.isClicked()){
            switch(e.buttonName){
              
              case "Square":
                extend = "default";
                s = new Shape(width/2, height/2, 50, 50, 0, 0, 255, "SQUARE", "Horizontal");
                sceneSandbox.dragging = s;
                sceneSandbox.shapes.add(s);
                break;
              case "Circle":
                extend = "default";
                s = new Shape(width/2, height/2, 50, 50, 255, 0, 0, "CIRCLE", "Vertical");
                sceneSandbox.dragging = s;
                sceneSandbox.shapes.add(s);
                break;
              case "Triangle":
                extend = "default";
                s = new Shape(width/2, height/2, 50, 50, 0, 255, 0, "TRIANGLE", "Scale");
                sceneSandbox.dragging = s;
                sceneSandbox.shapes.add(s);
                break;
              case "To Square":
                extend = "default";
                if(selected != null){
                  selected.changeShape("SQUARE");
                }
                break;
              case "To Circle":
                extend = "default";
                if(selected != null){
                  selected.changeShape("CIRCLE");
                }
                break;
              case "To Triangle":
                extend = "default";
                if(selected != null){
                  selected.changeShape("TRIANGLE");
                }
                break;
              case "Red":
                extend = "default";
                if(selected != null){
                  selected.changeColor(255, 0, 0);
                }
                break;
              case "Blue":
                extend = "default";
                if(selected != null){
                  selected.changeColor(0, 0, 255);
                }
                break;
              case "Green":
                extend = "default";
                if(selected != null){
                  selected.changeColor(0, 255, 0);
                }
                break;
              case "Horizontal":
              case "Vertical":
              case "Scale":
                extend = "default";
                if(selected != null){
                  selected.changeFunc(e.buttonName);
                }
                break;
              
            }
          }
        }
      } else {
        for (Button e : b.buttons){
          e.isVisible = false;
        }
      }
    }
    
    
    
  }
  
  void draw(){
    
    for (int i = 0; i < buttons.size(); i++) {
      Button b = buttons.get(i);
      b.draw();
      if (b.buttonName == extend){
        for (Button e : b.buttons){
           e.draw();
        }
      }
    }
    
  }
  
}

class Button {
  float x, y, w = 125, h = 50;
  String buttonName;
  color normalColor = 25, hoveredColor = 200, pressedColor = 60;
  color curColor;
  boolean title;
  boolean sand;
  boolean teach;
  boolean isVisible;
  boolean isHovered;
  boolean isClicked = false;
  boolean wasClicked = false;
  
  ArrayList<Button> buttons = new ArrayList();
  
  Button(float x, float y, String name, boolean isVisible, boolean title, boolean sand, boolean teach) {
    this.x = x;
    this.y = y;
    this.isVisible = isVisible;
    this.title = title;
    this.sand = sand;
    this.teach = teach;
    buttonName = name;
    curColor = normalColor;
  }
  void update(){
  
  if (mouseX > x - w/2 && mouseX < x + w/2 && mouseY > y - h/2 && mouseY < y + h/2) {
      isHovered = true;
      curColor = hoveredColor;
      if (Mouse.onDown(Mouse.LEFT) && !isClicked) {
        isClicked = true;
        curColor = pressedColor;
      }
    } else {
      isHovered = false;
      isClicked = false;
      curColor = normalColor;
    }
    
  }
  
  boolean isClicked() {
    if (isClicked && !wasClicked) { // Check if the button was just clicked
      wasClicked = true; // Set wasClicked to true to prevent repeated clicks
      return true;
    } else if (!Mouse.onDown(Mouse.LEFT)) { // If the mouse is released
      isClicked = false; // Reset isClicked
      wasClicked = false; // Reset wasClicked
    }
    return false;
  }
  
  void draw() {
    if (isVisible) {
      stroke(255);
      strokeWeight(2);
      fill(curColor);
      rect(x-w/2, y-h/2, w, h);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(18);
      text(buttonName, x, y);
      stroke(0);
      //noStroke();
    }
  }
  
}

class Textbox {
  String text;
  float x, y, w = 1200, h = 200, textSize;
  
  
  Textbox(float x, float y, float w, float h, float textSize, String text){
   this.text = text; 
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
   this.textSize = textSize;
  }
  
  void draw(){
    stroke(0);
    strokeWeight(3);
    fill(255);
    rect(x - w/2, y - h/2, w, h);
    fill(0);
    textAlign(LEFT, LEFT);
    textSize(textSize);
    text(text, x - w/2 + 6, y - h/2 + 20);
    stroke(0);
  }
  
}
