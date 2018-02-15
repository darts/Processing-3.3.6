class Alien {
  int xPos; //x-Position
  int yPos;  //y-Position
  PImage alienHead; //The head
  PImage alienExplode = loadImage("Explosion.png"); //The image used in the explosion animation
  boolean movingDown; //If the alien is moving down the side of the screen
  int dx; //x-velocity
  int dy; //y-velocity
  int distDown; //how far down the alien has travelled
  float explosionT; //how far into the explode animation the alien is.
  boolean exploding; //is the alien exploding
  boolean exploded; //is the alien finished exploding
  int timeToDrop; //Time until alien tries to drop a bomb
  boolean hasBomb; //has an alien dropped a bomb recently
  SoundFile popSound; //The deathsound of the alien

  Alien(int x, int y, int img, int moveVel, PApplet audio) {
    //Given 1 of 2 images depending on input.
    if (img == 0)
      alienHead = loadImage("AlienHeadReallySmall.png");
    else
      alienHead = loadImage("OtherAlien.png");
    xPos = x;
    yPos = y;
    movingDown = false;
    dx = moveVel;
    dy = 2;
    distDown = 0;
    explosionT = 120;
    timeToDrop = -1;
    hasBomb = false;
    popSound = new SoundFile(audio, "pop.wav");
  }

  //Moves the alien in whichever axis neccessary.
  void move(BombArray bombArray, PApplet audio) {
    dropBomb(bombArray, audio); //Tries to drop a bomb
    //If the alien is at the edge, moves it down for a certain distance and then back across the screen.
    if (movingDown && distDown <= IMG_HEIGHT + Y_MARGIN) {
      yPos += dy;
      distDown += dy;
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
    if (!exploded && !exploding) {//Fine
      image(alienHead, xPos, yPos);
    } else if (exploding && !exploded) {//Exploding
      if (explosionT - EXPLOSION_INCREMENT <= 0) {
        exploded = true;
      } else {
        explosionT -= EXPLOSION_INCREMENT;
        alienExplode.resize(0, (int)explosionT);
        image(alienExplode, xPos, yPos);
      }
    }
  }

  //Literally changes a variable and plays the death sound.
  void explode() {
    popSound.play();
    exploding = true;
  }

  //Returns the xPosition of the alien (for collision).
  int getX() {
    return xPos;
  }

  //Returns the yPosition of the alien (for collision).
  int getY() {
    return yPos;
  }

  //Tries to drop a bomb. If one is dropped, makes sure it can't drop another until the bomb goes off the screen.
  void dropBomb(BombArray bombArray, PApplet audio) {
    timeToDrop--;
    if (yPos > 0 && timeToDrop < 0) { //If alien is on screen and timer to drop is active (ie the alien has just moved onto the screen), give it a new timer.
      timeToDrop = (int)random(0, BOMB_FREQUENCY);
    } else if (yPos > 0 && timeToDrop <= 0 && !hasBomb) { //Tries to drop bomb if timer and yPos are valid and doesn't have a bomb.
      if (bombArray.addBomb(xPos, yPos, audio)) {//Tries to bomb, if successful gives new timer so can't drop until bomb has gone offscreen.
        hasBomb = true;
        timeToDrop = (int)random(0, BOMB_FREQUENCY) + (SCREEN_Y + BOMB_HEIGHT - yPos);
      } else {//Gives a slightly shorter bomb timer.
        timeToDrop = (int)random(0, BOMB_FREQUENCY);
      }
    } else if (yPos > 0 && timeToDrop == 0 && hasBomb) {//Bomb has gone offscreen, get new countdown timer.
      hasBomb = false;
      timeToDrop = (int)random(0, BOMB_FREQUENCY);
    }
  }
}