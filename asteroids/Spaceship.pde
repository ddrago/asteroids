class Spaceship{
  private float x;
  private float y;
  private float r;
  private int lives;
  
  public Spaceship(float ox, float oy){
    this.x = ox;
    this.y = oy;
    this.r = 10;
    this.lives = 3;
  }
  
  public float getX(){
    return this.x;
  }
  
  public float getY(){
    return this.y;
  }
    
  public float getR(){
    return this.r;
  }
  public int getLives(){
    return this.lives;
  }
  
  public void display(){
    triangle(-this.getR(), this.getR(), this.getR(), this.getR(), 0, -this.getR());
  }
  
}
