Alien alienStream[];
Player thePlayer;
ArrayList<Bullet> bulletStream;
void settings() {
  size(SCREEN_X, SCREEN_Y);
}

void setup() {
  alienStream = new Alien[10];
  noStroke();
  init_array(alienStream);
  thePlayer = new Player(SCREEN_Y - (PLAYER_Y + 20));
}
void draw() {
  background(255);
  thePlayer.move(mouseX);
  thePlayer.draw();
  move_array(alienStream);
  draw_array(alienStream);
}

void mousePressed() {
  bulletStream.add(new Bullet(thePlayer.getCentre()));
}

void init_array(Alien theArray[]) {
  for (int i=0; i<theArray.length; i++)
    theArray[i] = new Alien((i * (IMG_WIDTH + MARGIN)), STARTING_Y, (int)random(0, 2), random(0, 3));
}    
void draw_array(Alien theArray[]) {
  for (int i=0; i<theArray.length; i++)
    theArray[i].draw();
}
void move_array(Alien theArray[]) {
  for (int i=0; i<theArray.length; i++)
    theArray[i].move();
}

void moveBullets() {
}

void drawBullets() {
}