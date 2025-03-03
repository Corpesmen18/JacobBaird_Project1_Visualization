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
  float radius, angle, damage;
  boolean isDead;
  PVector position, velocity;
  AABB aabb;


  Bullet (float x, float y, float radius, float angle, float damage) {
    position.x = x;
    position.y = y;
    this.radius = radius;
    this.angle = angle;
    this.damage = damage;
    aabb = new AABB(x, y, radius, radius);
  }

  void update() {
    position.x += velocity.x * cos(angle) * dt;
    position.y += velocity.y * sin(angle) * dt;
  }

  void draw() {
    strokeWeight(1);
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
