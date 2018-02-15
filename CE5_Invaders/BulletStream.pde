class BulletStream { //<>//
  ArrayList<Bullet> bulletStream; //The arraylist of bullets
  int bulletLim; //Max amount of bullets
  int defaultStart; //Makes sure bullets start from the centre of the player
  boolean doubleBullets; //if two bullets should be fired (powerup)
  int bulletVel; //Speed of the bullet
  boolean isSine; //If a bullet should travel in a sine wave

  BulletStream() {
    isSine = false;
    bulletLim = BULLET_LIMIT;
    bulletStream = new ArrayList<Bullet>();
    defaultStart = ((IMG_WIDTH / 2) + BULLET_X); //Calculates the location offset for the bullet to appear like it is fired from the centre of the spacecraft
    doubleBullets = false;
    bulletVel = DEF_BULLET_SPEED;
  }

  //Moves the array of bullets.
  void moveBullets() {
    for (int index = 0; index < bulletStream.size(); index++) {
      bulletStream.get(index).move();
    }
  }

  //Draws the array of bullets.
  void drawBullets() { 
    for (int index = 0; index < bulletStream.size(); index++) {
      bulletStream.get(index).draw();
    }
  }

  //Adds a bullet if the number of bullets is below the limit.
  //Changes the type of bullet based on the current powerUp (if any).
  void addBullet(int xPos, PApplet audio) {
    if (!doubleBullets) {//Normal, fast or sine bullets
      if (bulletStream.size() < bulletLim)
        bulletStream.add(new Bullet(xPos + defaultStart, bulletVel, isSine, audio));
    } else {//Double bullets
      if (bulletStream.size() < bulletLim) {
        bulletStream.add(new Bullet(xPos + 25, DEF_BULLET_SPEED, false, audio));
        bulletStream.add(new Bullet((xPos + PLAYER_X - 35), DEF_BULLET_SPEED, false, audio));
      }
    }
  }

  //Checks if any bullet has hit an alien.
  boolean hitAlien(Alien alien) {
    for (int index = 0; index < bulletStream.size(); index++) {
      if (bulletStream.get(index).collide(alien))
        return true;
    }
    return false;
  }

  //Return if a bullet in the array has hit a shield and removes it.
  boolean hitShield(Shield shield) {
    for (int index = 0; index < bulletStream.size(); index++) {
      if (bulletStream.get(index).collide(shield)) {
        bulletStream.remove(index);
        return true;
      }
    }
    return false;
  }

  //Deletes bullets that have gone off the screen
  void delOutSide() {
    for (int index = 0; index < bulletStream.size(); index++) {
      if (bulletStream.get(index).isOutOfRange())
        bulletStream.remove(index--);
    }
  }

  //Applies powerUps based on randomly selected variable every time it is called (when an alien is hit)
  void powerUp() {
    int power = (int)random(0, POWERUP_RARITY);
    //Double bullets. Doubles bullet limit too.
    if (power == 1) {
      bulletLim = BULLET_LIMIT * 2;
      doubleBullets = true;
    }
    //Fast bullets. Normal bullet limit
    if (power == 2) {
      bulletLim = BULLET_LIMIT;
      doubleBullets = false;
      bulletVel = DEF_BULLET_SPEED * 2;
      isSine = false;
    }
    //Sine bullets. Normal bullet limit
    if (power == 3) {
      println("Sine bullets");
      bulletLim = BULLET_LIMIT;
      doubleBullets = false;
      bulletVel = DEF_BULLET_SPEED;
      isSine = true;
    }
  }
  
  //Returns a bullet. Can't remember if/when this is used.
  Bullet getBullet(int index) {
    return bulletStream.get(index);
  }
}