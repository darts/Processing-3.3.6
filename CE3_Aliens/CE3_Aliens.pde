Alien alienStream[];

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  alienStream = new Alien[10];
  noStroke();
  init_array(alienStream);
}
void draw() {
  background(255);
  move_array(alienStream);
  draw_array(alienStream);
}
void init_array(Alien theArray[]) {
  for (int i=0; i<theArray.length; i++)
    theArray[i] = new Alien((i * (IMGWIDTH + MARGIN)), STARTINGY);
}    
void draw_array(Alien theArray[]) {
  for (int i=0; i<theArray.length; i++)
    theArray[i].draw();
}
void move_array(Alien theArray[]) {
  for (int i=0; i<theArray.length; i++)
    theArray[i].move();
}