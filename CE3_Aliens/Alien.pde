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
  float sinState;
  int defaultLvl;

  Alien(int x, int y, int img, float useSin) {
    if (useSin > 1)
      sinState = useSin;
    else
      sinState = 0;

    if (img == 0)
      alienHead = loadImage("AlienHeadReallySmall.png");
    else
      alienHead = loadImage("OtherAlien.png");
    xPos = x;
    yPos = y;
    defaultLvl = yPos;
    movingDown = false;
    dx = 2;
    dy = 2;
    distDown = 0;
    explodeTime = (int)random(200, 1600);
    explosionT = 120;
  }

  void move() {
    // explodeTime--;
    if (movingDown && distDown <= IMGHEIGHT + YMARGIN) {
      yPos += dy;
      distDown += dy;
      if (distDown == IMGHEIGHT + YMARGIN)
        defaultLvl += IMGHEIGHT + YMARGIN;
    } else {
      if (xPos <= SCREENX - RETURNRANGE && xPos >= RETURNRANGE) {
        yPos += calcSinOffset(sinState, xPos);
      } else {
        for (int i = 0; i < RETURNSPEED; i++) {
          returnToDefaultY();
        }
      }
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
    } else if (!exploded) {
      if (!exploding) {
        //explodeTime = 120;
        exploding = true;
      }
      explode();
      //image(alienExplode, xPos, yPos);
    }
  }

  void explode() {
    if (exploded) {
    } else {
      if (explosionT - EXPLOSIONINCREMENT <= 0) {
        exploded = true;
      } else {
        explosionT -= EXPLOSIONINCREMENT;
        alienExplode.resize(0, (int)explosionT);
        image(alienExplode, xPos, yPos);
      }
    }
  }

  int calcSinOffset(float sinState, int xPos) {
    return (int)((sinState * 4) * sin((xPos / 10) + (sinState * 3)));
  }

  void returnToDefaultY() {
    if (yPos > defaultLvl)
      yPos--;
    else if (yPos < defaultLvl)
      yPos++;
  }
}