int sand = 115;
int [] sandStormx = new int[sand];
int [] sandStormy = new int[sand];
int sandTrail = 0;
Sun eclipse;
Pyramid pyramid;
ArrayList<Staircase> stairs;
Head head;
Hat hat;
Body body;
Arms larm;
Arms rarm;
Legs lleg;
Legs rleg;
Pelvis pelvis;
int armAngle = 0;
int angleChange = 2;
final int ANGLE_LIMIT = 90; // right arm will rotate around 0 to 135 degrees
int value = color(0, 128, 255);

void setup(){
  size(600,600);
  hat = new Hat(color(23,23,255), 300, 380, 60, 60, radians(180)/1.2, radians(390));
  pyramid = new Pybase(color(173,155,128), 0, 600, 300, 120, 600, 600);
  stairs = new ArrayList<Staircase>();
  head = new Head(color(234,192,134), 300, 400, 50, 50);
  body = new Body(color(255, 255, 255), 300, 485, 80, 120);
  larm = new Arms(color(234,192,134), 200, 450, 60, 30);
  rarm = new Arms(color(234,192,134), 325, 450, 60, 30);
  lleg = new Legs(color(21, 96, 189), 265, 550, 30, 60);
  rleg = new Legs(color(21, 96, 189), 310, 550, 30, 60);
  pelvis= new Pelvis(color(0, 0, 0), 265, 540, 75, 20);
  eclipse = new Sun(color(253, 184, 19), 300, 50, 100, 100);
 
  
}
void mousePressed(){
  pushMatrix();
  stairs.add(new Staircase(250, mouseY, 100, 30));
  popMatrix();
}
void keyPressed() {
  if (value == color(0, 128, 255)) {
    value = color(255, 140, 0);
  } else {
    value = color(0, 128, 255);
  }
}
void draw(){
  background(value);
  sandStormx[sandTrail] = mouseX;
  sandStormy[sandTrail] = mouseY;
  
  sandTrail = (sandTrail + 1) % sand;
  for(int i = 0; i <sand; i++){
    int pos = (sandTrail + i) % sand;
    float sandSize = (sand-i) / 2.5;
    ellipse(sandStormx[pos], sandStormy[pos], sandSize, sandSize);
  }

  pyramid.display();
 
  eclipse.display();
    for(int i= stairs.size()-1; i >=0; i--){
    Staircase stair = stairs.get(i);
    stair.appear();
    if(stair.stairDisappear()){
      stairs.remove(i);
    
}
  }

  
  hat.display();
  head.display();
  body.display();
  larm.display();

  lleg.display();
  rleg.display();
  pelvis.display();
  eclipse.sunEclipse();
  rarm.display();
  armAngle +=angleChange;
  
  if(armAngle > ANGLE_LIMIT || armAngle < 0){
    angleChange = -angleChange;

}


}
interface Egypt{
  void display();
  
}


class Sun implements Egypt {
  color c;
  int x; 
  int y;
  int w;
  int h;
  
  Sun(color sunC, int xpos, int ypos, int sunWidth, int sunHeight){
    c = sunC;
    x = xpos;
    y = ypos;
    w = sunWidth;
    h = sunHeight;
  }
  void display(){
    fill(c);
    ellipse(x, y, w, h);
}
  void sunEclipse(){

  

  if(keyPressed == true){
    fill(0);
  }
  else {
    fill(253, 184, 19);
  }
  ellipse(x, y, w, h);
 
}

}
abstract class Traveler {
  abstract void display();
  protected color c;
  protected int x;
  protected int y;
  protected int w;
  protected int h;
  
  Traveler(color tempC, int xpos, int ypos, int widthBody, int heightBody){
    c = tempC;
    x = xpos;
    y = ypos;
    w = widthBody;
    h = heightBody;
    
   
  }
}
  class Hat extends Traveler {
    protected float s;
    protected float e;
    
    Hat(color c, int x, int y, int w, int h, float start, float end){
      super(c, x, y, w, h);
      s = start;
      e = end;
    }
    void display(){
      pushMatrix();
      fill(c);
      arc(x, y, w, h, s, e);
      popMatrix();
    }
  }
  class Head extends Traveler {
    protected int headW;
    
    Head(color c, int x, int y, int w, int h){
      super(c, x, y, w, h);
      headW = h;
    }
  
    void display(){
      fill(c);
      ellipse(x, y, w, h);
    }
  
  }
  class Body extends Traveler {
    protected int torsoHeight;
    
    Body(color c, int x, int y, int w, int h){
      super(c, x, y, w, h);
      torsoHeight = h;
    }
    
    void display(){
      fill(c);
      ellipse(x, y, w, h);
  }
  }
  class Arms extends Traveler {
    protected int armLength;
    
    Arms(color c, int x, int y, int w, int h){
      super(c, x, y, w, h);
      armLength = w;
    }
    void display(){
      pushMatrix();
      fill(c);
        translate(335, 450); //Pivot Points for right arm
      rotate(radians(-armAngle));
      rect(0, 0, w, h); // Rotation occurs around the origin point (0,0)
      popMatrix();
      fill(c);
      rect(200, 450, 60, 30);
      
    }
   

    }

  
  class Legs extends Traveler {
    protected int legLength;
    
    Legs(color c, int x, int y, int w, int h){
      super(c, x, y, w, h);
      legLength = h;
    }
    void display(){
      fill(c);
      rect(x, y, w, h);
    }
  }
  class Pelvis extends Traveler{
    protected int pelvisLength;
    
    Pelvis(color c, int x, int y, int w, int h){
      super(c, x, y, w, h);
      pelvisLength = w;
    }
    void display(){
      fill(c);
      rect(x, y, w, h);
    }
  }
 abstract class Pyramid {
   abstract void display();
    color c;
    int x1;
    int y1;
    int x2;
    int y2;
    int x3;
    int y3;
    
    
    
    Pyramid(color pyC, int x1pos, int y1pos, int x2pos, int y2pos, int x3pos, int y3pos){
      c = pyC;
      x1 = x1pos;
      y1 = y1pos;
      x2 = x2pos;
      y2 = y2pos;
      x3 = x3pos;
      y3 = y3pos;
    }
 }
 class Pybase extends Pyramid{
   
   Pybase(color c, int x1, int y1, int x2, int y2, int x3, int y3){
     super(c, x1, y1, x2, y2, x3, y3);
   }
    void display(){
      fill(c);
      triangle(x1, y1, x2, y2, x3, y3);
    }
}
abstract class Acension{
  abstract boolean stairDisappear();
  abstract void appear();
}
class Staircase extends Acension {
  int x;
  int y;
  int w;
  int h;
  int stair = 255;
  
  Staircase(int tempX, int tempY, int tempW, int tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  }
  boolean stairDisappear(){
    stair--;
    if(stair < 0){
      return true;
    }
    else{
      return false;
    }
  }
  void appear(){
    fill(0, stair);
    rect(x, y, w, h);
  }


}
