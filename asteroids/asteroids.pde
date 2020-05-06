//CONSTANTS
static final float MAXSPEED = 5;
static final float ANGULARSTEP = PI/32;
static final float A = 0.8;
static final float FRICTION = 0.85;
static final int MAXBULLETSNUM = 12;
static final int MAXASTEROIDNUM = 15;

PFont font;

Spaceship s;
ArrayList<Asteroid> a = new ArrayList<Asteroid>();

boolean go = false, turnright = false, turnleft = false;

void setup(){       
  
  textSize(100);
  font = loadFont("ErasITC-Bold-48.vlw");
  
  s = new Spaceship();
  
  size(700, 700);
}

void draw(){
  if(s.getLives()>=0){
    background(30);
    s.update(go, turnright, turnleft);
    
    //if the number of asteroids doesn't exceed the limit, spawn a new asteroid.
    if(a.size() == 0){
      for(int i = 0; i < MAXASTEROIDNUM; i++){
        Asteroid ass = new Asteroid();
        a.add(ass);
      }
    }
    
    //updates each asteroids, delete the out of bounds ones and splits ones hitten by a bullet
    for(int i = a.size()-1; i >= 0; i--){
      Asteroid current = a.get(i);
      current.update(); 
      //check if one of the flying bullets hits the current asteroid
      if(s.shotDown(current)){
        a.remove(i);
        if(current.getTier()>0){
          Asteroid a1 = new Asteroid(current.getX(), current.getY(), random(2*PI), current.getTier()-1);
          Asteroid a2 = new Asteroid(current.getX(), current.getY(), random(2*PI), current.getTier()-1);
          a.add(a1);
          a.add(a2);
        }
      }
      
      //if the ship is alive and drives into an asteroid it will explode
      if(s.collidesWith(current) && !s.isDead()){
        
        //explosion
        
        s.dies();
        print("lives left: ", s.getLives(), "\n");
      }
      
    }
  }  
  else {
    text("GAME OVER", width/2, height/2);
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
