class Bullet {
  int xPos;
  int yPos;
  int bulletSpeed;
  boolean useSine;//if the bullet should travel in a sine wave 
  SoundFile bulletSound;

  Bullet(int x, int bulletVel, boolean sine, PApplet audio) {
    bulletSpeed = bulletVel;
    xPos = x;
    useSine = sine;
    yPos = SCREEN_Y - (PLAYER_Y + 20);
    bulletSound = new SoundFile(audio, "bullet.wav");
    bulletSound.play();
  }

  //Moves the bullet in the y axis and if needed in the x axis.
  void move() {
    yPos -= bulletSpeed;
    if (useSine)//If the bullet needs to travel in a sine wave, move it in a sine wave.
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
    if (((xPos + BULLET_X) >= theAlien.getX()) && (xPos <= (theAlien.getX() + IMG_WIDTH)) && ((yPos + BULLET_Y) >= theAlien.getY()) && (yPos <= (theAlien.getY() + IMG_HEIGHT)) && yPos > 0) {
      return true;
    }
    return false;
  }

  //Detects if the bullet has collided with a shield.
  boolean collide(Shield theShield) {
    if (((xPos + BULLET_X) >= theShield.getX()) && (xPos <= (theShield.getX() + SHIELD_X_OFFSET)) && ((yPos + BULLET_Y) >= theShield.getY()) && (yPos <= (theShield.getY() + SHIELD_Y_OFFSET)) && yPos > 0) {
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