
SceneTitle sceneTitle;
SceneSandbox sceneSandbox;
SceneTeach sceneTeach;
SceneTD sceneTD;

Shape selected;
float dt;
float prevTime;
boolean debug;
String lastAction = "default";
Shape dragging;
PFont font;
PFont font20;

void setup() {
  size(1280, 720);
  background(128);
  switchToTitle();
  font = loadFont("Cambria-30.vlw");
  font20 = loadFont("Cambria-20.vlw");
  textFont(font);
}

void draw(){
  calcDeltaTime();
  
  if (sceneTitle != null){
    sceneTitle.update();
    if (sceneTitle != null) sceneTitle.draw();
  } else if (sceneSandbox != null){
    sceneSandbox.update();
    if(sceneSandbox != null) sceneSandbox.draw();
  } else if (sceneTeach != null){
    sceneTeach.update();
    if (sceneTeach != null) sceneTeach.draw();
  } else if (sceneTD != null) {
   sceneTD.update();
   if (sceneTD != null) sceneTD.draw();
  }
  Mouse.update();
}

void keyPressed() {
  Keyboard.handleKeyDown(keyCode);
}

void keyReleased() {
  Keyboard.handleKeyUp(keyCode);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    Mouse.handleKeyDown(Mouse.LEFT);
  }
  if (mouseButton == RIGHT) {
    Mouse.handleKeyDown(Mouse.RIGHT);
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    Mouse.handleKeyUp(Mouse.LEFT);
  }
  if (mouseButton == RIGHT) {
    Mouse.handleKeyUp(Mouse.RIGHT);
  }
}

void switchToTitle() {
  sceneTitle = new SceneTitle();
  sceneSandbox = null;
  sceneTeach = null;
  sceneTD = null;
}

void switchToSandbox(){
  sceneTitle = null;
  sceneSandbox = new SceneSandbox();
  sceneTeach = null;
  sceneTD = null;
}

void switchToTeach(){
  sceneTitle = null;
  sceneSandbox = null;
  sceneTeach = new SceneTeach();
  sceneTD = null;
}

void switchToTD(){
  sceneTitle = null;
  sceneSandbox = null;
  sceneTeach = null;
  sceneTD = new SceneTD();
}

void calcDeltaTime() {
  float currTime = millis();
  dt = (currTime - prevTime) / 1000.0;
  prevTime = currTime;
}
