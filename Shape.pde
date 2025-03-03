class Shape {
  float x, y, w, h, r, g, b, xOff = 0, yOff = 0, scale = 0;
  String shape;
  String func = "horizontal";
  boolean isHovered, Clicked = false, wasClicked = false;
  boolean highlight = false;
  boolean inheritingS = true, inheritingC = true, inheritingF = true;
  float theta = 0.0;
  
  float range = 100, damage = 1, CD = 1, speed = 20;
  
  AABB aabb;
  Shape parent;

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


    if (Mouse.onUp(Mouse.LEFT)) {
      dragging = null;
    }

    if (aabb.checkCollision() && Mouse.onDown(Mouse.LEFT)) {
      selected = this;
      dragging = this;
    }

    if (selected != null) {
      if (selected == this) {
        highlight(true);
      } else if (!selected.isChild(this)) {
        highlight = false;
      }
    }
    
    if(sceneTD != null){
      CD -= dt;
      if(CD <= 0){
        attemptShoot();
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

  void attemptShoot(){
    for (int i = 0; i < sceneTD.enemies.size(); i++){
      Enemy e = sceneTD.enemies.get(i);
      if (dist(x, y, e.position.x, e.position.y) <= range){
        shoot(e);
        break;
      }
    }
  }
  
  void shoot(Enemy e){
    Bullet b = new Bullet(x, y, e.position.x - x, e.position.y - y, 10, damage, speed);
    sceneTD.bullets.add(b);
    CD = 1;
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

  void resetOverrides() {
    inheritingF = true;
    inheritingC = true;
    inheritingS = true;
    if (parent != null) {
      xOff = 0;
      yOff = 0;
      scale = 0;
      func = parent.func;
      shape = parent.shape;
      r = parent.r;
      g = parent.g;
      b = parent.b;
      lastAction = "Reset Overrides";
    } else lastAction = "No Parent";
    for (Shape s : children) {
      s.changeShape(shape);
      s.changeFunc(func);
      s.changeColor(r, g, b);
    }
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

  public boolean checkContains(AABB other) {
    if (xmax < other.xmax) return true;
    if (xmin > other.xmin) return true;
    if (ymax < other.ymax) return true;
    if (ymin > other.ymin) return true;
    return false;
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

    if (sceneSandbox != null) {
      for (Shape s : sceneSandbox.shapes) {
        if (aabb.checkCollision(s.aabb)) {
          if (!isContained(s)) {
            if (target == null) {
              if (Mouse.onUp(Mouse.LEFT)) {
                target = s;
                shapes.add(s);
                lastAction = "Shape in container";
              }
            } else if (target.isChild(s) && Mouse.onUp(Mouse.LEFT)) {
              shapes.add(s);
              if (s.inheritingF == false || s.inheritingC == false || s.inheritingC == false) {
                lastAction = "Overridden child";
              } else lastAction = "Child in container";
            } else if (dragging != s) {
              s.repel(x, y);
              lastAction = "Rejected";
            }
          }
        } //else s.repel(x, y);
      }
    } else if (sceneTeach != null) {
      for (Shape s : sceneTeach.shapes) {
        if (aabb.checkCollision(s.aabb)) {
          if (!isContained(s)) {
            if (target == null) {
              if (Mouse.onUp(Mouse.LEFT)) {
                target = s;
                shapes.add(s);
                lastAction = "Shape in container";
              }
            } else if (target.isChild(s) && Mouse.onUp(Mouse.LEFT)) {
              shapes.add(s);
              if (s.inheritingF == false || s.inheritingC == false || s.inheritingC == false) {
                lastAction = "Overridden child";
              } else lastAction = "Child in container";
            } else if (dragging != s) {
              s.repel(x, y);
              lastAction = "Rejected";
            }
          }
        } //else s.repel(x, y);
      }
    }

    for (Shape s : shapes) {
      if (aabb.checkContains(s.aabb)) {
        s.attract(x, y);
      }
    }

    if (aabb.checkCollision() && sceneSandbox != null) {
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

    if (Mouse.onUp(Mouse.RIGHT) && sceneSandbox != null) {
      sceneSandbox.drag = null;
    }
  }

  void draw() {
    noFill();
    strokeWeight(5);
    stroke(0);
    rect(x - w/2, y - h/2, w, h);
    strokeWeight(1);
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
