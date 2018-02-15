class Shield { //<>//
  int xPos, yPos;
  ArrayList<Shield> shieldLayout;
  PImage shield;
  boolean isPrimary; //If this shield is the parent shield
  SoundFile hitSound;

  //objType = 0 for main object, 1 for top left, 2 for top right, 3 for bottom left, 4 for bottom right
  Shield(int x, int y, int objType, PApplet audio) {
    hitSound = new SoundFile(audio, "splat.wav");
    xPos = x;
    yPos = y;
    isPrimary = false;
    
    //Which part of the shield an object is ie. which image
    if (objType == 1) {
      shield = loadImage("TopLeftShield.png");
    } else if (objType == 2) {
      shield = loadImage("TopRightShield.png");
    } else if (objType == 3) {
      shield = loadImage("BottomLeftShield.png");
    } else if (objType == 4) {
      shield = loadImage("BottomRightShield.png");
    } else {
      isPrimary = true;
      shieldLayout = new ArrayList<Shield>();
    }

    //Initialises each of the shield subobjects.
    for (int shieldPart = 1; shieldPart <= 4 && isPrimary; shieldPart++) {
      int xTrans = xPos, yTrans = yPos;
      if (shieldPart == 2) {
        xTrans += SHIELD_X_OFFSET;
      } else if (shieldPart == 3) {
        yTrans += SHIELD_Y_OFFSET;
      } else if (shieldPart == 4) {
        xTrans += SHIELD_X_OFFSET;
        yTrans += SHIELD_Y_OFFSET;
      }
      shieldLayout.add(new Shield(xTrans, yTrans, shieldPart, audio));
    }
  }

  //Draws the whole shield.
  void drawShield() {
    if (isPrimary) {
      for (int shieldPart = 0; shieldPart <= shieldLayout.size() - 1; shieldPart++) {//For the primary shield
        shieldLayout.get(shieldPart).drawShield();
      }
    } else {//Shield subobjects
      image(shield, xPos, yPos);
    }
  }

  //Checks if a bullet or bomb has hit the shield. If it has been hit, deletes it and plays sound effect.
  boolean collide(BulletStream bulletStream, BombArray bombArray) {
    for (int shieldNum = 0; shieldNum < shieldLayout.size(); shieldNum++) {//Checks if the player shot the shield.
      if (bulletStream.hitShield(shieldLayout.get(shieldNum))) {
        hitSound.play();
        shieldLayout.remove(shieldNum--);
        return true;
      }
    }

    for (int bombNum = 0; bombNum < shieldLayout.size(); bombNum++) {//Checks if the alien bombs hit the shield
      if (bombArray.hitShield(shieldLayout.get(bombNum))) {
        hitSound.play();
        shieldLayout.remove(bombNum--);
        return true;
      }
    }
    return false;
  }

  int getX() {
    return xPos;
  }

  int getY() {
    return yPos;
  }

  //Returns the array of shields.
  ArrayList<Shield> getParts() {
    return shieldLayout;
  }
}