class Alien {
  int xPos;
  int yPos;
  PImage alienHead;
  PImage alienExplode = loadImage("Explosion.png");
  boolean movingDown;
  int dx;
  int dy;
  int distDown;
  int explodeTime;
  float explosionT;
  boolean exploding;
  boolean exploded;
  int defaultLvl;

  Alien(int x, int y, int img, int moveVel) {
    if (img == 0)
      alienHead = loadImage("AlienHeadReallySmall.png");
    else
      alienHead = loadImage("OtherAlien.png");
    xPos = x;
    yPos = y;
    defaultLvl = yPos;
    movingDown = false;
    dx = moveVel;
    dy = 2;
    distDown = 0;
    explodeTime = (int)random(200, 1600);
    explosionT = 120;
  }

  //Moves the alien in whichever axis neccessary.
  void move() {
    if (movingDown && distDown <= IMG_HEIGHT + Y_MARGIN) {
      yPos += dy;
      distDown += dy;
      if (distDown == IMG_HEIGHT + Y_MARGIN)
        defaultLvl += IMG_HEIGHT + Y_MARGIN;
    } else {
      movingDown = false;
      distDown = 0;
      if (xPos > (SCREEN_X - IMG_WIDTH) || xPos < 0) {
        dx = -dx;
        movingDown = true;
      }
      xPos += dx;
    }
  }

  //If it's fine -> draw the head.
  //If it's exploding -> draw the explode animation.
  //If it's exploded -> do nothing (will be deleted elsewhere).
  void draw() {
    if (!exploded && !exploding) {
        image(alienHead, xPos, yPos);
    }else if(exploding && !exploded){
       if (explosionT - EXPLOSION_INCREMENT <= 0) {
        exploded = true;
      } else {
        explosionT -= EXPLOSION_INCREMENT;
        alienExplode.resize(0, (int)explosionT);
        image(alienExplode, xPos, yPos);
      }
    }
  }
  
  //Literally changes a variable.
  void explode() {
    exploding = true;
  }
  
  int getX() {
    return xPos;
  }

  int getY() {
    return yPos;
  }
}