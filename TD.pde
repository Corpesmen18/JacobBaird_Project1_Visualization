class SceneTD {
  ArrayList<Shape> shapes = new ArrayList();
  ArrayList<Container> boxes = new ArrayList();
  ArrayList<Enemy> enemies = new ArrayList();
  ArrayList<Bullet> bullets = new ArrayList();
  
  Base base;
  float round = 1;
  float enemiesToSpawn = 5;
  float spawnCD = 2;
  float roundDelay = 5;
  float money = 50;
  
  HUD hud = new HUD();
  
  SceneTD(){
    hud.buttons.get(5).x = width - 75;
    hud.buttons.get(5).y = height - 40;
    Button b = hud.buttons.get(6);
    b.buttons.get(0).buttonName = "Square\n$40";
    b.buttons.get(1).buttonName = "Circle\n$40";
    b.buttons.get(2).buttonName = "Triangle\n$40";
    hud.buttons.get(7).buttonName = "New Child\n$60";
    
    base = new Base(150, height/2, 100, 100);
  }
  
  void update(){

    
    spawnCD -= dt;
    if (spawnCD <= 0 && enemiesToSpawn > 0) spawnEnemy();

    for(int i = 0; i < enemies.size(); i++){
      Enemy e = enemies.get(i);
      e.update();
      if(e.health <= 0 || e.position.x < -30){
        e.isDead = true;
        enemies.remove(e);
      }
    }
    
    for (int i = 0; i < shapes.size(); i++){
      Shape s = shapes.get(i);
      s.update();
    }
    
    for (int i = 0; i < bullets.size(); i++){
      bullets.get(i).update();
    }
    
    if(dragging != null){
      dragging.x = mouseX;
      dragging.y = mouseY;
    }
    
    
    hud.update();
  }
  
  void draw(){
    background(48);
    for(Enemy e : enemies){
      e.draw();
    }
    for (int i = 0; i < shapes.size(); i++){
      Shape s = shapes.get(i);
      s.draw();
    }
    for (int i = 0; i < bullets.size(); i++){
      bullets.get(i).draw();
    }
    base.draw();
    
    hud.draw();
  }
  
  void spawnEnemy(){
    spawnCD = random(1, 2.5) / round;
    Enemy e = new Enemy(width, random(30, height - 30), 1, 1);
    enemies.add(e);
    enemiesToSpawn--;
  }
  
  void newRound(){
    round++;
    
  }
  
}

class Enemy {
  PVector position = new PVector();
  PVector velocity = new PVector();
  float health, damage;
  boolean isDead = false;
  AABB aabb;
  
  Enemy(float x, float y, float h, float d){
    position.x = x;
    position.y = y;
    velocity.x = -100;
    health = h;
    damage = d;
    aabb = new AABB(x, y, 50, 50);
  }
  
  void update(){
    position.x += velocity.x * dt;
    position.y += velocity.y * dt;
  }
  
  void draw(){
    fill(255, 0, 0);
    rect(position.x - 25, position.y - 25, 50, 50);
  }
  
}

class Bullet {
  float radius, damage;
  boolean isDead;
  PVector position = new PVector();
  PVector velocity =  new PVector();
  AABB aabb;


  Bullet (float x, float y, float vx, float vy, float radius, float damage) {
    position.x = x;
    position.y = y;
    velocity.x = vx;
    velocity.y = vy;
    this.radius = radius;
    this.damage = damage;
    aabb = new AABB(x, y, radius, radius);
  }

  void update() {
    position.x += velocity.x * dt;
    position.y += velocity.y * dt;
  }

  void draw() {
    strokeWeight(1);
    stroke(0);
    circle(position.x, position.y, radius);
    strokeWeight(2);
  }
}

class Base {
  PVector position = new PVector();
  float health, w, h;
  AABB aabb;
  
  Base(float x, float y, float w, float h){
    position.x = x;
    position.y = y;
    this.w = w;
    this.h = h;
    aabb = new AABB(position.x, position.y, w, h);
  }
  
  void update(){
    
    
    
  }
  
  void draw(){
    stroke(0);
    strokeWeight(4);
    fill(0, 0, 255);
    rect(position.x - w/2, position.y - h/2, w, h);
  }
  
}
