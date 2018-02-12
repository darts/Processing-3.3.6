class Player {
  int xPos;
  int yPos;
  PImage shipTexture;

  Player(int y) {
    xPos = (SCREEN_X / 2) - (PLAYER_X / 2); 
    yPos = y; 
    shipTexture = loadImage("SpaceShip.png");
  }

  //Moves the  player to the variable passed if it is in range.
  void move(int x) {
    if ((x + PLAYER_X) < SCREEN_X)
      xPos = x;
  }
  
  //Draws the player.
  void draw() {
    image(shipTexture, xPos, yPos);
  }

  //Returns the center of the spaceship
  int getCentre() {
    return (xPos + (PLAYER_X /2));
  }
  
  int getX(){
   return xPos;
  }
  
  int getY(){
    return yPos;
  }
}