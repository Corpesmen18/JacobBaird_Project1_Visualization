class Shape {
  float x, y, w, h, r, g, b;
  String shape;
  boolean isHovered, Clicked = false, wasClicked = false;
  boolean highlight = false;
  AABB aabb;
  
  ArrayList<Shape> children = new ArrayList();
  
  Shape (float x, float y, float w, float h, float r, float g, float b, String shape){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.g = g;
    this.b = b;
    this.shape = shape;
    aabb = new AABB(x, y, w, h);
  }
  
  void update(){
    
    aabb.recalc(x, y, w, h);
    
    
    
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
        rect(x - w/2, y - h/2, w, h);
        break;
      case "CIRCLE":
        fill(r, g, b);
        circle(x, y, w);
        break;
      case "TRIANGLE":
        fill(r, g, b);
        triangle(x - w/2, y + h/2, x + w/2, y + h/2, x, y - h/2);
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
