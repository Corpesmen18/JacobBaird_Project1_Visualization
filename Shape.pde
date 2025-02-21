class Shape {
  float x, y, w, h, r, g, b;
  String shape;
  boolean isHovered, isClicked = false, wasClicked = false;
  AABB aabb;
  
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
    
    
    
  }
  
  void draw(){
    
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
  
}

class AABB {
  
  private boolean colliding = false;
  private float xmin, xmax, ymin, ymax;
  
  AABB(float x, float y, float w, float h){
    xmin = x - w;
    xmax = x + w;
    ymin = y - h;
    ymax = y + h;
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
