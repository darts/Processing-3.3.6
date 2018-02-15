class BombArray {
  ArrayList<Bomb> bombArray; //THe arraylist of bombs
  
  BombArray() {
    bombArray = new ArrayList<Bomb>();
  }

  //Adds a bomb to the array if the number of bombs is below the max.
  boolean addBomb(int x, int y, PApplet audio) {
    if (bombArray.size() < BOMB_LIMIT){
      bombArray.add(new Bomb(x, y, audio));
      return true;
    }
    return false;
  }
  
  //Detects whether an item in the array has collided with a shield.
  boolean hitShield(Shield shield) {
    for (int index = 0; index < bombArray.size(); index++) {
      if (bombArray.get(index).collide(shield)) {//removes bomb that has collided
        bombArray.remove(index--); //post-decrement on index is because object has been removed
        return true;
      }
    }
    return false;
  }

  //Detects whether an item in the array has collided with a player.
  boolean hitPlayer(Player player) {
    for (int index = 0; index < bombArray.size(); index++) {
      if (bombArray.get(index).collide(player)) {
        return true;
      }
    }
    return false;
  }
  
  //Moves the array of bombs.
  void move() {
    removeOffScreen();
    for (int index = 0; index < bombArray.size(); index++) {
      bombArray.get(index).move();
    }
  }

  //Draws the array of bombs.
  void draw() {
    for (int index = 0; index < bombArray.size(); index++)
      bombArray.get(index).draw();
  }
  
  //Removes any bombs that have gone off the screen.
  void removeOffScreen(){
    for(int count = 0; count < bombArray.size(); count++){
      if(bombArray.get(count).offScreen())
        bombArray.remove(count--);
    }
  }
}