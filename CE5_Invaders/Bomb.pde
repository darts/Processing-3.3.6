class Bomb{
  int xPos, yPos;
  Bomb(int x, int y){
    xPos = x;
    yPos = y;
  }
  
  void move(){
   yPos -= DEF_BOMB_SPEED; 
  }
  
  int getX(){
    return xPos;
  }
  int getY(){
    return yPos;
  }
  
}