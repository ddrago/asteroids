class Bullet{
  private float x, y; //choords
  private float b, h; //dimensions
  private float v = MAXSPEED;
  private float dir;
  
  Bullet(float x, float y, float dir){
    this.x = x;
    this.y = y;
    this.b = 1;
    this.h = 2;
    this.dir = dir;
  }
  //SETTERS AND GETTERS
  private float getX(){
    return this.x;
  }
  private void setX(float x){
    this.x = x;
  }
  
  private float getY(){
    return this.y;
  }
  private void setY(float y){
    this.y = y;
  }
  
  private float getB(){
    return this.b;
  }
  
  private float getH(){
    return this.h;
  }
  
  private float getV(){
    return this.v;
  }
  
  private float getDir(){
    return this.dir;
  }
  
  private void move(){
    this.setX(this.getX() + this.getV()*cos(this.getDir()));
    this.setY(this.getY() + this.getV()*sin(this.getDir()));
  }
  
  private void display(){
    push();
    stroke(255);
    rectMode(CENTER);
    rect(this.getX(), this.getY(), this.getB(), this.getH());
    pop();
  }
  
  public void update(){
    this.move();
    this.display();
  }
    
  public boolean outOfBounds(){
    return (x<0 || x>width || y<0 || y>height);
  }
}
