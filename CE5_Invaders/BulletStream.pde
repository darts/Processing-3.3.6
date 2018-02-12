class BulletStream { //<>//
  ArrayList<Bullet> bulletStream;
  int bulletLim;
  int defaultStart;
  boolean doubleBullets;
  int bulletVel;
  boolean isSine;
  
  BulletStream() {
    isSine = false;
    bulletLim = BULLET_LIMIT;
    bulletStream = new ArrayList<Bullet>();
    defaultStart = ((IMG_WIDTH / 2) + BULLET_X); 
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
  void addBullet(int xPos) {
    if (!doubleBullets) {
      if (bulletStream.size() < bulletLim)
        bulletStream.add(new Bullet(xPos + defaultStart, bulletVel, isSine));
    }else{
      if (bulletStream.size() < bulletLim){
        bulletStream.add(new Bullet(xPos + 25, DEF_BULLET_SPEED, false));
        bulletStream.add(new Bullet((xPos + PLAYER_X - 35), DEF_BULLET_SPEED, false));  
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
    //Double bullets.
    if (power == 1) {
      println("Double bullets");
      bulletLim = BULLET_LIMIT * 2;
      doubleBullets = true;
    }
    //Fast bullets.
    if (power == 2) {
      println("Fast bullets");
      bulletLim = BULLET_LIMIT;
      doubleBullets = false;
      bulletVel = DEF_BULLET_SPEED * 2;
      isSine = false;
    }
    //Sine bullets.
    if(power == 3){
      println("Sine bullets");
      bulletLim = BULLET_LIMIT;
      doubleBullets = false;
      bulletVel = DEF_BULLET_SPEED;
      isSine = true;
    }
  }
}