class Asteroid{
  private float x, y, r; //choords and radius
  private float v, dir; //speed and direction
  
  private int tier; //can only be an integer from 1 to 4;
  private int vertNum; //number of vertices
  
  private final float MAXASTEROIDSIZE = 100;
  private final int MAXJAGGEDNESS = 5;
  private float[] offsets;
  
  private FloatDict speeds = new FloatDict();
  private FloatDict radii = new FloatDict();
  private IntDict vertices = new IntDict();
  
  public Asteroid(){
    
    //fill the dictionaries with the data necessary. 
    //Higher tier (big num) -> bigger and slower. Low tier (smol num) -> smol and fast
    for(int i = 0; i < 4; i++) {
      //maps "<tier as int>" to the max speed. Low tiers -> MAXSPEED divided by a smaller number -> fast bois
      this.speeds.set(str(i), MAXSPEED/(i+2));
      //maps "<tier as int>" to the max asteroid radius divided by a bigger power of 2 the bigger the tier
      this.radii.set(str(i), this.MAXASTEROIDSIZE/pow(2, 4-i));  
      //the bigger, the more vertices. random numbers thrown in that i think will look pretty
      this.vertices.set(str(i), 4*i+5);   
    }
    
    /*spawn the asteroid, whatever their tier may be, either from the top border, going down
      from the right border going left
      from the bottom border, going up or
      from the left border, going right.
    */
    this.tier = int(random(4));  //at random, choose what tier will this asteroid be
    
    //get their tier-dependent radius, speed and number of vertices
    this.r = this.radii.get(str(this.tier));
    this.v = this.speeds.get(str(this.tier));
    this.vertNum = this.vertices.get(str(this.tier));
    
    int border = int(random(4)); //at random, chose from which border will it spawn
    
    switch(border){
      case 0: this.x = random(width);
              this.y = -25;
              this.dir = random(2*PI/6, 4*PI/6); //directed down, angle between 240° and 300° degrees
              break;
      case 1: this.x = width + 25;
              this.y = random(height);
              this.dir = random(5*PI/6, 7*PI/6); //directed left, angle between 150° and 210°
              break;
      case 2: this.x = random(width);
              this.y = height + 25;
              this.dir = random(8*PI/6, 10*PI/6); //directed up, angle between 60° and 120°
              break;
      case 3: this.x = -25;
              this.y = random(height);
              this.dir = random(-PI/6, PI/6); //directed right, angle between 30° and -30°
    }
    
    //determine the offset for each vertex, determining how jagged the asteroid will look
    this.offsets = new float[this.vertNum];
    for (int i = 0; i < this.vertNum; i++){
      offsets[i] = random(MAXJAGGEDNESS);
    }
    
  }
  
  //just for asteroids spawned out of a previous, bigger, asteroid splitting
  public Asteroid(float x, float y, float dir, int tier){
    
    //fill the dictionaries with the data necessary. 
    //Higher tier (big num) -> bigger and slower. Low tier (smol num) -> smol and fast
    for(int i = 0; i < 4; i++) {
      //maps "<tier as int>" to the max speed. Low tiers -> MAXSPEED divided by a smaller number -> fast bois
      this.speeds.set(str(i), MAXSPEED/(i+2));
      //maps "<tier as int>" to the max asteroid radius divided by a bigger power of 2 the bigger the tier
      this.radii.set(str(i), this.MAXASTEROIDSIZE/pow(2, 4-i));  
      //the bigger, the more vertices. random numbers thrown in that i think will look pretty
      this.vertices.set(str(i), 4*i+5);   
    }
    
    this.x = x;
    this.y = y;
    this.dir = dir;  //technically we could just spawn the random angle here instead of getting it as a parametre...
     //but for flexibility let's pretend it's better like this
    
    if(tier<0 || tier > 4){
      print("what the fuck mate\n");
      this.tier = 0;
    }
    else {
      this.tier = tier;
    }
    
    //get their tier-dependent radius, speed and number of vertices
    this.r = this.radii.get(str(this.tier));
    this.v = this.speeds.get(str(this.tier));
    this.vertNum = this.vertices.get(str(this.tier));
    
    //determine the offset for each vertex, determining how jagged the asteroid will look
    this.offsets = new float[this.vertNum];
    for (int i = 0; i < this.vertNum; i++){
      offsets[i] = random(MAXJAGGEDNESS);
    }
    
  }
  
  //SETTERS AND GETTERS
  //X 
  public float getX(){
    return this.x;
  }
  public void setX(float x){
    this.x = x;
  }
  
  //Y
  public float getY(){
    return this.y;
  }
  public void setY(float y){
    this.y = y;
  }
  
  //R
  private float getR(){
    return this.r;
  }
  
  //V
  private float getV(){
    return this.v;
  }
  
  //Dir
  private float getDir(){
    return this.dir;
  }
  
  private int getTier(){
    return this.tier;
  }
  
  private int getVertNum(){
    return this.vertNum;
  }
  
  private void move(){
    this.setX(this.getX() + this.getV()*cos(this.getDir()));
    this.setY(this.getY() + this.getV()*sin(this.getDir()));
  }
  
  private void display(){
    push();
    fill(30);
    stroke(255);
    //circle(this.getX(), this.getY(), this.getR());
    translate(this.getX(), this.getY());
    beginShape();
    //instead of just using a circle, build a polygon out of a circle
    for(int i = 0; i<this.getVertNum(); i++){
      float angle = map(i, 0, this.getVertNum(), 0, PI*2);
      //each vertex' choords depend on the angle
      float x = this.getR()*cos(angle) + this.offsets[i];
      float y = this.getR()*sin(angle) + this.offsets[i];
      vertex(x, y);
    }
    endShape(CLOSE);
    pop();
  }
  
  private void update(){
    
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
    
    this.move();
    this.display();
  }
  
  public boolean outOfBounds(){
    return (x<-50 || x>width+50 || y<-50 || y>height+50);
  }
  
  

}
