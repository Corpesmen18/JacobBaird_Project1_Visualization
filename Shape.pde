class Shape {
  float x, y, w, h, r, g, b;
  String shape;
  
  Shape (float x, float y, float w, float h, float r, float g, float b, String shape){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.g = g;
    this.b = b;
    this.shape = shape;
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
        triangle(x - w, y + h, x + w, y + h, x, y - h);
        break;
      
    }
    
  }
  
}
