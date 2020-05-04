class Cartridge{
  
  private ArrayList<Bullet> c = new ArrayList<Bullet>();
  
  public int size(){
    return this.c.size();
  }
  
  public void add(Bullet b){
    this.c.add(b);
  } 
  
  public Bullet get(int i){
    return this.c.get(i);
  }
  
  public void update(){
    //the only way to iterate through a list in this case, is to iterate through it backwards
    
    if(this.size() > 0){
      for(int i = this.size() - 1; i >= 0; i--){
        Bullet b = this.c.get(i);
        b.update();
        if(b.outOfBounds()){
          this.c.remove(i);
        }
      }
    }
  }
  
  public void cprint(){
    //the only way to iterate through a list in this case, is to iterate through it backwards
    
    if(this.size() > 0){
      for(int i = this.size() - 1; i >= 0; i--){
        Bullet b = this.c.get(i);
        print("bullet: ", b.getX(), ", ", b.getY(), ", ", b.getDir(), "\n");   
      }
    }
  }
  
}
