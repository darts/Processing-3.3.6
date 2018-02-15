class Player {  
  int xPos;
  int yPos;
  PImage shipTexture;
  PImage shipExplode;
  float explosionT; //How far into the explode animation the player is (scales the explosion image)
  boolean exploding;
  boolean exploded;

  Player(int y) {
    xPos = (SCREEN_X / 2) - (PLAYER_X / 2); //Places the player in the center of the screen
    yPos = y; 
    shipTexture = loadImage("SpaceShip.png");
    shipExplode = loadImage("Explosion.png");
    exploding = false;
    exploded = false;
    shipExplode.resize(0, SHIP_EXPLOSION_SCALE);
    explosionT = SHIP_EXPLOSION_INC;
  }

  //Moves the  player to the variable passed if it is in range.
  void move(int x) {
    if ((x + PLAYER_X) < SCREEN_X)
      xPos = x;
  }
  
  //Returns the center of the spaceship
  int getCentre() {
    return (xPos + (PLAYER_X / 2));
  }
  
  //Returns if the player has been hit.
  boolean isHit(BombArray bombArray){
    return bombArray.hitPlayer(this);
  }
  
  //If it's fine -> draw the player.
  //If it's exploding -> draw the explode animation.
  //If it's exploded -> do nothing.
  void draw() {
    if (!exploded && !exploding) {//Fine
      image(shipTexture, xPos, yPos);
    } else if (exploding && !exploded) {//Exploding
      if (explosionT - EXPLOSION_INCREMENT <= 0) {
        exploded = true;
      } else {
        explosionT -= EXPLOSION_INCREMENT;
        shipExplode.resize(0, (int)explosionT);
        image(shipExplode, getCentre(), yPos + (PLAYER_Y / 2));
      }
    }
  }

  //Literally changes a variable.
  void explode() {
    exploding = true;
  }
  
  int getX(){
   return xPos;
  }
  
  int getY(){
    return yPos;
  }
}