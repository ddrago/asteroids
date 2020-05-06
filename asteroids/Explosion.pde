class Explosion{
  
  private float x, y, v, size; //choords, speed and size of particles
  private int n, brightness; //number of particles and their brightness
  private final float OFFSET = PI/8;
  private Particle[] particles = new Particle[n];
  
  Explosion(float x, float y, int n = 10){
    this.x = x;
    this.y = y;
    this.size = 2;
    this.n = n;
    this.brightness = 255;
    
    for(int i = 0; i < PI*2; i += (PI*2)/n ){
      particles[i].x = x;
      particles[i].y = y;
      particles[i].dir = i + random(this.OFFSET);
    }
    
  }
  
  //SETTERS AND GETTERS
  
  private float getV(){
    return this.v;
  }
  private void setV(float v){
    this.v = v;
  }
  
  private int getBrightness(){
    return this.brightness;
  }
  private void lowerBrightness(){
    this.brightness = this.brightness - 3;
  }
  
  private void display(int brightness){
    for(Particle p : particles){
      push();
      stroke(brightness);
      rectMode(CENTER);
      rect(p.x, p.y, this.size, this.size);
      pop();
    }
  }
  
  private void move(){
    for(Particle p : particles){
      this.setV(this.getV()*FRICTION);
      p.setX( p.getX() + cos(p.getDir())*this.getV());
      p.setY( p.getY() + sin(p.getDir())*this.getV());
    }
  }
  
  //update each particle, dimming them, moving them. Return true while explosion still happening
  public boolean update(){
    if(this.getBrightness() > 0){
      this.move();
      this.display(this.getBrightness());
      this.lowerBrightness();
      return true;
    }
    return false;
  }
  
  class Particle{
    float x, y, dir;
    
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
    
    public float getDir(){
      return this.dir;
    } 
    public void setDir(float dir){
      this.dir = dir;
    }
  }
  
}
