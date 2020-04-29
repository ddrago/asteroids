Spaceship s;
float ox = -width/2;
float oy = -height/2;

void setup(){
  s = new Spaceship(ox, oy);
  size(700, 700);
}

void draw(){
  background(30);
  s.display();
}
