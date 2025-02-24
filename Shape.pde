class Shape {
  float x, y, w, h, r, g, b, xOff = 0, yOff = 0, scale = 0;;
  String shape;
  String func = "horizontal";
  boolean isHovered, Clicked = false, wasClicked = false;
  boolean highlight = false;
  float theta = 0.0;
  AABB aabb;
  
  ArrayList<Shape> children = new ArrayList();
  
  Shape (float x, float y, float w, float h, float r, float g, float b, String shape, String func){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.g = g;
    this.b = b;
    this.shape = shape;
    this.func = func;
    aabb = new AABB(x, y, w, h);
  }
  
  void update(){
    
    aabb.recalc(x, y, w, h);
    function();
    
    
    if(Mouse.onUp(Mouse.LEFT)){
      sceneSandbox.dragging = null;
    }
    
    if(aabb.checkCollision() && Mouse.onDown(Mouse.LEFT)){
      selected = this;
      sceneSandbox.dragging = this;
    }
    
    for (Shape s : children){
      s.update();
    }
    
    if(selected == this){
      highlight(true);
    } else highlight = false;
    
    
    
  }
  
  void draw(){
    
    for (Shape s : children){
      if(sceneSandbox.debug){
        stroke(r, g, b);
        line(x, y, s.x, s.y);
      }
      s.draw();
    }
    
    stroke(0);
    if(highlight){
      stroke(255);
    }
    
    
    switch(shape){
     
      case "SQUARE":
        fill(r, g, b);
        rect(x - w/2 + xOff - scale/2, y - h/2 + yOff - scale/2, w + scale, h + scale);
        break;
      case "CIRCLE":
        fill(r, g, b);
        circle(x + xOff, y + yOff, w + scale);
        break;
      case "TRIANGLE":
        fill(r, g, b);
        triangle(x - w/2 + xOff - scale, y + h/2 + yOff + scale, x + w/2 + xOff + scale, y + h/2 + yOff + scale, x + xOff, y - h/2 + yOff - scale);
        break;
      
    }    
    
  }
  
  void highlight(boolean h){
    highlight = h;
    
    for(Shape s : children){
      s.highlight(h);
    }
    
  }
  
  public void changeShape(String newShape){
    shape = newShape;
    for(Shape s : children){
      s.changeShape(newShape);
    }
  }
  
  public void changeColor(float r, float g, float b){
    this.r = r;
    this.g = g;
    this.b = b;
    
    for(Shape s : children){
      s.changeColor(r, g, b);
    }
    
  }
  
  void changeFunc(String f){
    xOff = 0;
    yOff = 0;
    scale = 0;
    func = f;
    for(Shape s : children){
      s.changeFunc(f);
    }
  }
  
  void function(){
    
    switch (func){
      case "Horizontal":
        xOff = sin(theta) * 5;
        break;
      case "Vertical":
        yOff = sin(theta) * 5;
        break;
      case "Scale":
        scale = sin(theta) * 5;
        break;
    }
    theta += .1;
    
  }
  
  boolean isChild(Shape shape){
    
    for(Shape s : children){
      if(s == shape){
        return true;
      }
      if (s.isChild(shape)){
        return true;
      }
    }
    return false;
  }
  
}

class AABB {
  
  private boolean colliding = false;
  private float xmin, xmax, ymin, ymax;
  
  AABB(float x, float y, float w, float h){
    xmin = x - w/2;
    xmax = x + w/2;
    ymin = y - h/2;
    ymax = y + h/2;
  }
  
  public void recalc (float x, float y, float w, float h){
    xmin = x - w/2;
    xmax = x + w/2;
    ymin = y - h/2;
    ymax = y + h/2;
  }
  
  public void resetColliding(){
    colliding = false;
  }
  
  public boolean checkCollision(){
    if (xmax < mouseX) return false;
    if (xmin > mouseX) return false;
    if (ymax < mouseY) return false;
    if (ymin > mouseY) return false;
    colliding = true; 
    return true;
  }
  
}

class Container {
  ArrayList<Shape> shapes = new ArrayList();
  float x, y, w, h;
  Shape target;
  AABB aabb;
  
  Container(float x1, float y1, float x2, float y2){
    
    if (x1 > x2){
      x = (x1 - x2)/2 + x2;
      w = x1 - x2;
    } else {
      x = (x2 - x1)/2 + x1;
      w = x2 - x1;
    }
    
    if (y1 > y2){
      y = (y1 - y2)/2 + y2;
      h = y1 - y2;
    } else {
      y = (y2 - y1)/2 + y1;
      h = y2 - y1; 
    }
    
    if (h < 60){
      h = 60;
    }
    if (w < 60){
      w = 60;
    }
    aabb = new AABB(x, y, w, h);
  }
  
  void update(){
    
    if(aabb.checkCollision()){
      if(Mouse.onDown(Mouse.RIGHT)){
        sceneSandbox.drag = this;
      }
    }
    
    if(Mouse.onUp(Mouse.RIGHT)){
        sceneSandbox.drag = null;
    }
    
  }
  
  void draw(){
    noFill();
    stroke(0);
    rect(x - w/2, y - h/2, w, h);
  }
  
}
