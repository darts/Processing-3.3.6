class Player {
  int xPos;
  int yPos;
  PImage shipTexture;

  Player(int y) {
    xPos = (SCREEN_X / 2) - (PLAYER_X / 2); 
    yPos = y; 
    shipTexture = loadImage("SpaceShip.png");
  }

  void move(int x) {
    if ((x + PLAYER_X) < SCREEN_X)
      xPos = x;
  }

  void draw() {
    image(shipTexture, xPos, yPos);
  }

  int getCentre() {
    return (xPos + (PLAYER_X /2));
  }
}