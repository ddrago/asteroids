class Spaceship{
  private float x;
  private float y;
  private float r;
  
  private float dir;
  private float v;
  private float a;
  
  private int lives;
  
  public Spaceship(){
    this.x = width/2;
    this.y = height/2;
    this.r = 10;
    
    this.dir = -PI/2;
    this.v = 3;
    this.a = 0;
    
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
  
  //lives
  public int getLives(){
    return this.lives;
  }
  
  private void turn(boolean turnright, boolean turnleft){
    if(turnright){
      this.setDir(this.getDir() - ANGULARSTEP);
    }
    if(turnleft){
      this.setDir(this.getDir() + ANGULARSTEP);
    }
  }
  
  private void move(boolean go){    
    if(go){
      this.setX( this.getX() + cos(this.getDir())*this.getV());
      this.setY( this.getY() + sin(this.getDir())*this.getV());
    }
    
  }
  
  private void display(){
    /*
    float x1 = this.getX() + this.getR();
    float y1 = this.getY();
    
    float x2 = this.getX() - this.getR();
    float y2 = this.getY() + this.getR();
    
    float x3 = this.getX() - this.getR();
    float y3 = this.getY() - this.getR();
    */
    
    float x1 = this.getR();
    float y1 = 0;
    
    float x2 = -this.getR();
    float y2 = this.getR();
    
    float x3 = -this.getR();
    float y3 = -this.getR();
    
    
    translate(this.getX(), this.getY());
    rotate(this.getDir());
    noFill();
    stroke(255);
    circle(0, 0, 3);
    triangle(x1, y1, x2, y2, x3, y3);
  }
  
  public void update(boolean go, boolean turnright, boolean turnleft){
    this.turn(turnright, turnleft);
    this.move(go);
    print("x: ", this.getX(), ", y: ", this.getY(), "\n"); 
    
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
    
    this.display();
  }
  
}
