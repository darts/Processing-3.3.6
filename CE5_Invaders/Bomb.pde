class Bomb {
  int xPos, yPos;
  PImage alienBomb;
  SoundFile bombSound;

  Bomb(int x, int y, PApplet audio) {
    alienBomb = loadImage("Bomb.png");
    xPos = x;
    yPos = y;
    bombSound = new SoundFile(audio, "bomb.wav");
    bombSound.play();//Plays the sound of the bomb being dropped.
  }

  //Moves the bomb.
  void move() {
    yPos += DEF_BOMB_SPEED;
  }

  //Draws the bomb.
  void draw() {
    image(alienBomb, xPos, yPos);
  }

  //Checks if the bomb has gone off the bottom of the screen.
  boolean offScreen() {
    if (yPos > SCREEN_Y)
      return true;
    return false;
  }

  //Checks for collision with a player.
  boolean collide(Player thePlayer) {
    if (((xPos + BOMB_WIDTH) >= thePlayer.getX()) && (xPos <= (thePlayer.getX() + PLAYER_X)) && ((yPos + BOMB_HEIGHT) >= thePlayer.getY()) && (yPos <= (thePlayer.getY() + PLAYER_Y)) ) {
      return true;
    }
    return false;
  }

  //Checks for collision with a shield.
  boolean collide(Shield theShield) {
    if (((xPos + BOMB_WIDTH) >= theShield.getX()) && (xPos <= (theShield.getX() + SHIELD_X_OFFSET)) && ((yPos + BOMB_HEIGHT) >= theShield.getY()) && (yPos <= (theShield.getY() + SHIELD_Y_OFFSET)) && yPos > 0) {
      return true;
    }
    return false;
  }

  int getX() {
    return xPos;
  }
  int getY() {
    return yPos;
  }
}