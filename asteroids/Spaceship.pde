class Spaceship{
  private float x;
  private float y;
  private float r;
  
  private float dir;
  private float v;
  
  private Cartridge c;
  private int lives;
  
  public Spaceship(){
    this.x = width/2;
    this.y = height/2;
    this.r = 10;
    
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
    
    //the three vertices of our spaceship
    float x1 = this.getR();
    float y1 = 0;
    
    float x2 = -this.getR();
    float y2 = this.getR();
    
    float x3 = -this.getR();
    float y3 = -this.getR();
    
    //we move the origin of the canvas to wherever the centre of the spaceship is
    translate(this.getX(), this.getY()); 
    //we rotate the spaceship to whatever is the direction headed to
    rotate(this.getDir());
    
    //make it nice and pretty
    noFill();
    stroke(255);
    circle(0, 0, 3);
    triangle(x1, y1, x2, y2, x3, y3);
    
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
    
    //finally display the spaceship on the canvas
    this.display();
    this.getCartridge().update();
  }
 
   public void shoot(){
     //only shoot if the cartridge isn't empty
     if(c.size() < MAXBULLETSNUM){
       Bullet b = new Bullet(this.getX(), this.getY(), this.getDir());
       this.getCartridge().add(b);
     }
   }
   
   public boolean shotDown(Asteroid a){
     //iterate through the bullets that have been shot
     for(int i = this.getCartridge().size() - 1; i <= 0; i--){
       if(this.getCartridge().get(i).hits(a)){
         return true;
       }
     }
     return false;
   }
  
}
