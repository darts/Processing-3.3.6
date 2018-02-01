class Alien {
  int xPos;
  int yPos;
  PImage alienHead = loadImage("AlienHeadReallySmall.png");
  PImage alienExplode = loadImage("1.gif");
  boolean movingDown;
  int dx;
  int dy;
  int distDown;
  int explodeTime;
  float explosionT;
  boolean exploding;
  boolean exploded;

  Alien(int x, int y) {
    xPos = x;
    yPos = y;
    movingDown = false;
    dx = 2;
    dy = 2;
    distDown = 0;
    explodeTime = (int)random(200, 1600);
    explosionT = 120;
  }

  void move() {
    // explodeTime--;
    if (movingDown && distDown < IMGHEIGHT) {
      yPos += dy;
      distDown += dy;
    } else {
      movingDown = false;
      distDown = 0;
      if (xPos > (SCREENX - IMGWIDTH) || xPos < 0) {
        dx = -dx;
        movingDown = true;
      }
      xPos += dx;
    }
  }

  void draw() {
    if (--explodeTime > 0) {
      image(alienHead, xPos, yPos);
    } else if(!exploded){
      if(!exploding){
       //explodeTime = 120;
       exploding = true;
      }
      explode();
      //image(alienExplode, xPos, yPos);
    }
  }
  
  void explode(){
    if(exploded){
    }else{
      if(explosionT - EXPLOSIONINCREMENT <= 0){
        exploded = true;
    }else{
      explosionT -= EXPLOSIONINCREMENT;
      alienExplode.resize(0, (int)explosionT);
      image(alienExplode, xPos, yPos);
    }
    }
  }
}