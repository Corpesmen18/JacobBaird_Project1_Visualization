class Shape {
  float x, y, w, h, r, g, b, xOff = 0, yOff = 0, scale = 0;
  ;
  String shape;
  String func = "horizontal";
  String tower = "basic";
  boolean isHovered, Clicked = false, wasClicked = false;
  boolean highlight = false;
  boolean inheritingS = true, inheritingC = true, inheritingF = true;
  float theta = 0.0;
  AABB aabb;

  ArrayList<Shape> children = new ArrayList();

  Shape (float x, float y, float w, float h, float r, float g, float b, String shape, String func) {
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

  void update() {

    aabb.recalc(x, y, w, h);
    function();

    //for(Shape s : sceneSandbox.shapes){
    //  if (aabb.checkCollision(s.aabb) && s != this){
    //    println("hitting");
    //  }
    //}

    switch (tower) {
    case "basic":

      break;
    }

    if (Mouse.onUp(Mouse.LEFT)) {
      dragging = null;
    }

    if (aabb.checkCollision() && Mouse.onDown(Mouse.LEFT)) {
      selected = this;
      dragging = this;
    }

    //for (Shape s : children){
    //  s.update();
    //}

    if (selected != null) {
      if (selected == this) {
        highlight(true);
      } else if (!selected.isChild(this)) {
        highlight = false;
      }
    }
  }

  void draw() {

    for (Shape s : children) {
      if (debug) {
        stroke(r, g, b);
        line(x + xOff, y + yOff, s.x + s.xOff, s.y + s.yOff);
      }
      //s.draw();
    }

    stroke(0);
    if (highlight) {
      stroke(255);
    }


    switch(shape) {

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

  void highlight(boolean h) {
    highlight = h;

    for (Shape s : children) {
      s.highlight(h);
    }
  }

  public void changeShape(String newShape) {
    if (inheritingS) {
      shape = newShape;
      for (Shape s : children) {
        s.changeShape(newShape);
      }
    }
  }

  public void iChangeShape(String newShape) {
    inheritingS = false;
    shape = newShape;
    for (Shape s : children) {
      s.changeShape(newShape);
    }
  }

  public void changeColor(float r, float g, float b) {
    if (inheritingC) {
      this.r = r;
      this.g = g;
      this.b = b;

      for (Shape s : children) {
        s.changeColor(r, g, b);
      }
    }
  }

  public void iChangeColor(float r, float g, float b) {
    inheritingC = false;
    this.r = r;
    this.g = g;
    this.b = b;

    for (Shape s : children) {
      s.changeColor(r, g, b);
    }
  }

  void changeFunc(String f) {
    if (inheritingF) {
      xOff = 0;
      yOff = 0;
      scale = 0;
      func = f;
      for (Shape s : children) {
        s.changeFunc(f);
      }
    }
  }

  public void iChangeFunc(String f) {
    inheritingF = false;
    xOff = 0;
    yOff = 0;
    scale = 0;
    func = f;
    for (Shape s : children) {
      s.changeFunc(f);
    }
  }

  void function() {

    switch (func) {
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

  boolean isChild(Shape shape) {

    for (Shape s : children) {
      if (s == shape) {
        return true;
      }
      if (s.isChild(shape)) {
        return true;
      }
    }
    return false;
  }

  void repel(float x, float y) {
    x = x - this.x;
    y = y - this.y;
    this.x -= x * dt;
    this.y -= y * dt;
  }

  void attract(float x, float y) {
    x = this.x - x;
    y = this.y - y;
    this.x -= x * dt;
    this.y -= y * dt;
  }
}

class AABB {

  private boolean colliding = false;
  private float xmin, xmax, ymin, ymax;

  AABB(float x, float y, float w, float h) {
    xmin = x - w/2;
    xmax = x + w/2;
    ymin = y - h/2;
    ymax = y + h/2;
  }

  public void recalc (float x, float y, float w, float h) {
    xmin = x - w/2;
    xmax = x + w/2;
    ymin = y - h/2;
    ymax = y + h/2;
  }

  public void resetColliding() {
    colliding = false;
  }

  public boolean checkCollision() {
    if (xmax < mouseX) return false;
    if (xmin > mouseX) return false;
    if (ymax < mouseY) return false;
    if (ymin > mouseY) return false;
    colliding = true;
    return true;
  }

  public boolean checkCollision(AABB other) {
    if (xmax < other.xmin) return false;
    if (xmin > other.xmax) return false;
    if (ymax < other.ymin) return false;
    if (ymin > other.ymax) return false;
    return true;
  }
}

class Container {
  ArrayList<Shape> shapes = new ArrayList();
  float x, y, w, h;
  float px, py;
  Shape target;
  AABB aabb;

  Container(float x1, float y1, float x2, float y2) {

    if (x1 > x2) {
      x = (x1 - x2)/2 + x2;
      w = x1 - x2;
    } else {
      x = (x2 - x1)/2 + x1;
      w = x2 - x1;
    }

    if (y1 > y2) {
      y = (y1 - y2)/2 + y2;
      h = y1 - y2;
    } else {
      y = (y2 - y1)/2 + y1;
      h = y2 - y1;
    }

    if (h < 60) {
      h = 60;
    }
    if (w < 60) {
      w = 60;
    }
    aabb = new AABB(x, y, w, h);
  }

  void update() {

    aabb.recalc(x, y, w, h);
    println(shapes.size());
    println(target);

    for (Shape s : sceneSandbox.shapes) {
      if (aabb.checkCollision(s.aabb)) {
        if (!isContained(s)) {
          if (target == null) {
            if (Mouse.onUp(Mouse.LEFT)) {
              target = s;
              shapes.add(s);
            }
          } else if (target.isChild(s) && Mouse.onUp(Mouse.LEFT)) {
            shapes.add(s);
          } else s.repel(x, y);
        }
      } //else s.repel(x, y);
    }

    if (aabb.checkCollision()) {
      if (Mouse.onDown(Mouse.RIGHT)) {
        sceneSandbox.drag = this;
      }
      if (Mouse.onDown(Mouse.LEFT) && shapes.size() > 0) {
        dragging = shapes.get(shapes.size() - 1);
        shapes.remove(shapes.size() - 1);
        if (shapes.size() == 0) {
          target = null;
        }
      }
    }

    if (Mouse.onUp(Mouse.RIGHT)) {
      sceneSandbox.drag = null;
    }
  }

  void draw() {
    noFill();
    stroke(0);
    rect(x - w/2, y - h/2, w, h);
  }

  boolean isContained(Shape s) {
    for (Shape b : shapes) {
      if (s == b) {
        return true;
      }
    }
    return false;
  }
}

// secret game code

class Bullet {
  float x, y, radius, angle, damage;
  boolean isDead;
  PVector velocity;
  AABB aabb;


  Bullet (float x, float y, float radius, float angle, float damage) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.angle = angle;
    this.damage = damage;
    aabb = new AABB(x, y, radius, radius);
  }

  void update() {
    x += velocity.x * cos(angle) * dt;
    y += velocity.y * sin(angle) * dt;
  }

  void draw() {
    strokeWeight(1);
    circle(x, y, radius);
    strokeWeight(2);
  }
}
