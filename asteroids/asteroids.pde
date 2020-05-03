//CONSTANTS
static final float MAXSPEED = 5;
static final float ANGULARSTEP = PI/32;
static final float A = 0.8;
static final float FRICTION = 0.85;
static final int MAXBULLETSNUM = 12;
static final float MAXASTEROIDSIZE = 100;
static final int MAXASTEROIDNUM = 15;

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
  
  //if the number of asteroids doesn't exceed the limit, spawn a new asteroid.
  if(a.size()<MAXASTEROIDNUM){
    Asteroid ass = new Asteroid();
    a.add(ass);
  }
  
  //delete the out of bounds asteroids 
  for(int i = a.size()-1; i>= 0; i--){
    a.get(i).update(); 
    if(a.get(i).outOfBounds()){
      a.remove(i);
    }
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
    s.shoot();
  }
}
