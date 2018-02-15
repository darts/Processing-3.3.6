class ShieldArray {
  int xPos, yPos, spacing, shieldCount;
  Shield[] shieldArray;
  
  //Creates a row of shields.
  ShieldArray(int xStart, int yStart, int spacing, int shieldCount, PApplet audio) {
    xPos = xStart;
    yPos = yStart;
    shieldArray = new Shield[shieldCount];
    this.spacing = spacing; //Gap between each shield
    this.shieldCount = shieldCount; //Number of shields
    initArray(xPos, yPos, spacing, audio);
  }
  
  //Initialises the row, creating each of the shield objects.
  void initArray(int xStart, int yStart, int spacing, PApplet audio) {
    for (int shieldNum = 0; shieldNum < shieldArray.length; shieldNum++)
      shieldArray[shieldNum] = new Shield(xStart + ((SHIELD_WIDTH + spacing) * shieldNum), yStart, NEW_SHIELD, audio);
  }

  //Checks if any of the shields have been hit.
  void collided(BulletStream bulletStream, BombArray bombArray) {
    for(int shieldNum = 0; shieldNum < shieldArray.length; shieldNum++){
      shieldArray[shieldNum].collide(bulletStream, bombArray);
    }
  }
  
  //Draws all of the shields.
  void draw(BulletStream bulletStream, BombArray bombArray){
    for(int shieldNum = 0; shieldNum < shieldArray.length; shieldNum++){
      shieldArray[shieldNum].drawShield();
      collided(bulletStream, bombArray);
    }
  }
}