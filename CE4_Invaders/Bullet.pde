class Bullet {
  int xPos;
  int yPos;

  Bullet(int x) {
    xPos = x; 
    yPos = SCREEN_Y - (PLAYER_Y + 20);
  }

  void move() {
    yPos--;
  }

  void draw() {
    fill(0);
    rect(xPos, yPos, BULLET_X, BULLET_Y);
  }
}