class AlienStream {
  ArrayList<Alien> alienStream; //The arraylist of aliens
  Alien currentAlien;
  
  AlienStream() {
    alienStream = new ArrayList<Alien>();
  }

  //Generates aliens in a snake pattern so they appear to have been generated in a single stream (sorta snake-like). 
  //Generates as many aliens as has been defined in the constants.
  void initStream(int numOfAliens, PApplet audio) {
    int alienVel = ALIEN_START_VEL;
    int yStart = STARTING_Y;
    for (int index = 0, xMul = 0; index <= numOfAliens; index++, xMul++) {//Creates as many aliens as required
      if (xMul * (IMG_WIDTH + MARGIN) >= SCREEN_X) {
        xMul = 0;
        yStart -= (IMG_HEIGHT + Y_MARGIN);
        alienVel = -alienVel;
      }
      alienStream.add(new Alien((xMul * (IMG_WIDTH + MARGIN)), yStart, (int)random(0, 2), alienVel,audio));//Adds alien
    }
  }

  //Draws the array of aliens.
  void drawAliens() {
    for (int index = 0; index < alienStream.size(); index++)
      alienStream.get(index).draw();
  }

  //Checks if the aliens have been hit. Any hit alien is made to explode and a powerUp is 'dropped'.
  //If the alien has not been hit, it is moved.
  void moveAliens(BulletStream bulletStream, BombArray bombArray, PApplet audio) {
    for (int index = 0; index < alienStream.size(); index++) {
      currentAlien = alienStream.get(index);
      if (!currentAlien.exploding && !currentAlien.exploded) {
        if (bulletStream.hitAlien(currentAlien)){//If alien is hit, drop a powerup and blow up the alien
          currentAlien.explode();
          bulletStream.powerUp();
        }
        alienStream.get(index).move(bombArray, audio);
      } else if (currentAlien.exploded) {//Removes dead aliens
        alienStream.remove(index--);
      }
    }
  }
}