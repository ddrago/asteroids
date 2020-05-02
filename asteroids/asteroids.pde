//CONSTANTS
static final float MAXSPEED = 5;
static final float ANGULARSTEP = PI/32;
static final float A = 0.8;
static final float FRICTION = 0.85;
static final int MAXBULLETSNUM = 12;
static final float MAXASTEROIDRADIUS = 20;

Spaceship s;
ArrayList<Asteroid> a = new ArrayList<Asteroid>();

boolean go = false, turnright = false, turnleft = false;

void setup(){
  s = new Spaceship();
  size(700, 700);
}

void draw(){
  background(30);
  s.update(go, turnright, turnleft);
  
  for(int i = a.size()-1; i>= 0; i--){
    print("wtf, ", i);
    a.get(i).update();  
  }
  
}

void keyPressed(){
  if(key == CODED){
    
    if(keyCode == UP){
      go = true;
    }
    if(keyCode == RIGHT){
      turnright = true;
    }
    if(keyCode == LEFT){
      turnleft = true;
    }
  } 
}

void keyReleased(){
  if(keyCode == UP){
    go = false;
  }
  if(keyCode == RIGHT){
    turnright = false;
  }
  if(keyCode == LEFT){
    turnleft = false;
  }  
  if(key == ' '){
    Asteroid ass = new Asteroid();
    s.shoot();
  }
}
