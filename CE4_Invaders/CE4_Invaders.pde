Player thePlayer;
AlienStream alienStream;
BulletStream bulletStream;
Bullet bullet;
void settings() {
  size(SCREEN_X, SCREEN_Y);
}

void setup() {
  alienStream = new AlienStream();
  bullet = new Bullet(-100);
  noStroke();
  alienStream.initStream(NUM_OF_ALIENS);
  thePlayer = new Player(SCREEN_Y - (PLAYER_Y + 20));
  //bulletStream = new ArrayList<Bullet>();  
  bulletStream = new BulletStream();
}
void draw() {
  background(255);
  thePlayer.move(mouseX);
  thePlayer.draw();
  bulletStream.moveBullets();
  bulletStream.drawBullets();
  bulletStream.delOutSide();
  alienStream.moveAliens();
  alienStream.drawAliens();
  
}

void mousePressed() {
  bulletStream.addBullet(mouseX);
}