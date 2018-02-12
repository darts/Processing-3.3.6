class Bullet {
  int xPos;
  int yPos;
  int bulletSpeed;
  boolean useSine;
  
  Bullet(int x, int bulletVel, boolean sine) {
    bulletSpeed = bulletVel;
    xPos = x;
    useSine = sine;
    yPos = SCREEN_Y - (PLAYER_Y + 20);
  }

  //Moves the bullet in the y axis and if needed in the x axis.
  void move() {
    yPos -= bulletSpeed;
    if (useSine)
      xPos += calcSinOffset(yPos);
  }

  //Draws the bullet.
  void draw() {
    fill(0);
    rect(xPos, yPos, BULLET_X, BULLET_Y);
  }

  //Detects if the bullet has gone off the screen.
  boolean isOutOfRange() {
    if (yPos < (-BULLET_Y))
      return true;
    return false;
  }

  //Detects if the bullet has collided with an alien.
  boolean collide(Alien theAlien) {
    if (((xPos + BULLET_X) >= theAlien.getX()) && (xPos <= (theAlien.getX() + IMG_WIDTH)) && ((yPos + BULLET_Y) >= theAlien.getY()) && (yPos <= (theAlien.getY() + IMG_HEIGHT)) ) {
      return true;
    }
    return false;
  }

  //Calculates the offset in the x axis used for sinusoidal movement.
  int calcSinOffset(int yPos) {
    return (int)(15 * sin((yPos / 40)));
  }

  int getX() {
    return xPos;
  }

  int getY() {
    return yPos;
  }
}