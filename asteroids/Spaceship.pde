class Spaceship{
  private float x;
  private float y;
  private float r;
  
  private float[][] relativeVertices;
  
  private float dir;
  private float v;
  
  private Cartridge c;
  private int lives;
  private int respawning = 0;  //if the ship is respawning, asteroids will pass through
  private int dead = 0;
  
  public Spaceship(){
    this.x = width/2;
    this.y = height/2;
    this.r = 10;
    
    //the three vertices of our spaceship
    relativeVertices = new float[][]{ {this.getR(), 0}, {-this.getR(), this.getR()}, {-this.getR(), -this.getR()} };
    
    this.dir = -PI/2;
    this.v = 0;
    
    this.c = new Cartridge();
    this.lives = 3;
  }
  
  //GETTERS, SETTERS AND INCREMENTERS
  
  //x
  public float getX(){
    return this.x;
  }
  public void setX(float x){
    this.x = x;
  }
  
  //y
  public float getY(){
    return this.y;
  }
  public void setY(float y){
    this.y = y;
  }
  
  //r
  public float getR(){
    return this.r;
  }
  
  //dir
  public float getDir(){
    return this.dir;
  } 
  public void setDir(float dir){
    this.dir = dir;
  }
  
  //v
  public float getV(){
    return this.v;
  }
  public void setV(float v){
    this.v = v;
  }
  
  //cartridge
  public Cartridge getCartridge(){
    return this.c;
  }
  
  //lives
  public int getLives(){
    return this.lives;
  }
  public void decreaseLives(){
    if(this.lives > 0){
      this.lives = this.lives-1;
    }
  }
  
  public int getRespawning(){
    return this.respawning;
  }
  public void setRespawning(int n){
    this.respawning = n;
  }
  public boolean isRespawning(){
    return (this.respawning > 0);
  }
  
  public int getDead(){
    return this.dead;
  }
  public void setDead(int n){
    this.dead = n;
  }
  public boolean isDead(){
    return (this.dead > 0);
  }
    
  private void turn(boolean turnright, boolean turnleft){
    if(turnright){
      this.setDir(this.getDir() + ANGULARSTEP);
    }
    if(turnleft){
      this.setDir(this.getDir() - ANGULARSTEP);
    }
  }
  
  private void move(boolean go){    
    if(go){
      this.setV(this.getV() + A);
    }
     
    this.setV(this.getV()*FRICTION);
    this.setX( this.getX() + cos(this.getDir())*this.getV());
    this.setY( this.getY() + sin(this.getDir())*this.getV());
  }
  
  private void display(){
    push();
    
    //we move the origin of the canvas to wherever the centre of the spaceship is
    translate(this.getX(), this.getY()); 
    //we rotate the spaceship to whatever is the direction headed to
    rotate(this.getDir());
    
    //make it nice and pretty
    noFill();
    
    if(this.isRespawning()){
      stroke(255/2);
    }
    else{
      stroke(255);
    }
    circle(0, 0, 3);
    
    triangle( relativeVertices[0][0], relativeVertices[0][1], //first vertex
              relativeVertices[1][0], relativeVertices[1][1], //second vertex
              relativeVertices[2][0], relativeVertices[2][0]);//third vertex
    
    pop();
  }
  
  public void update(boolean go, boolean turnright, boolean turnleft){
  
    this.turn(turnright, turnleft);
    this.move(go);
    
    //make the canvas a loop: exit from the right, enter from the left
    if(this.getX()>width){
      this.setX(0);
    }
    if(this.getX()<0){
      this.setX(width);
    }
    
    if(this.getY()>height){
      this.setY(0);
    }
    if(this.getY()<0){
      this.setY(height);
    }
    
    //deal with respawn time
    if (this.isRespawning()){
      this.setRespawning(this.getRespawning() - 1);
    }
    else {
      this.setRespawning(0);
    }
    
    //deal with dead time
    if (this.isDead()){ //is dead
      this.setDead(this.getDead() - 1);
    }
    else {
      this.setDead(0);
      this.display(); //finally display the spaceship on the canvas
    }
 
    this.getCartridge().update();
  }
 
   public void shoot(){
     //only shoot if the cartridge isn't empty and you are alive
     if(c.size() < MAXBULLETSNUM && !this.isDead()){
       Bullet b = new Bullet(this.getX(), this.getY(), this.getDir());
       this.getCartridge().add(b);
     }
   }
   
   public boolean shotDown(Asteroid a){
     //iterate through the bullets that have been shot
     if(this.getCartridge().size() > 0){
       for(int i = this.getCartridge().size() - 1; i >= 0; i--){
         if(this.getCartridge().get(i).hits(a)){
           this.getCartridge().remove(i);
           return true;
         }
       }
     }
     return false;
   }
   
   public boolean collidesWith(Asteroid a){
     if(!this.isRespawning()){
       for(int i = 0; i < 3; i++){ 
         float vertexx = relativeVertices[i][0] + this.getX();
         float vertexy = relativeVertices[i][1] + this.getY();
         if( dist(vertexx, vertexy, a.getX(), a.getY()) < a.getR() ) {
           return true;
         }
       }
     }
     return false;
   }
   
   public void dies(){
      s.setDead(200);
      s.setRespawning(500);
      s.decreaseLives();   
   }

}
