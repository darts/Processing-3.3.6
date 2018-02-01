class Ball{
 float xPos;
 float yPos;
 float dx;
 float dy;
 int radius;
 color ballColour = color(200, 100, 50);
  
 Ball(){
   reset();
   resetVel();
   radius = BALLRADIUS;
   ellipseMode(RADIUS);
 }
 
 void move(){
   if(dx > BALLMAXXVEL)
     dx = BALLMAXXVEL;
   else if(dx < -BALLMAXXVEL)
     dx = -BALLMAXXVEL;
   if(dy > BALLMAXYVEL)
     dy = BALLMAXYVEL;
   else if(dy < -BALLMAXYVEL)
     dy = -BALLMAXYVEL;
   xPos += dx;
   yPos += dy;
 } 
 
 void draw(){
  fill(ballColour);
  ellipse(int(xPos), int(yPos), radius, radius);
 }
 
 void collide(Player player1, Player player2){
    if(xPos - radius <= 0) 
      dx = -dx;
    else if(xPos + radius >= SCREENX)
      dx = -dx;
    
    playerCollide(player1);
    playerCollide(player2);
  }
  
  void playerCollide(Player player){
    if(yPos + radius >= player.yPos && yPos - radius < player.yPos + PADDLEHEIGHT &&
    xPos > player.xPos && xPos <= player.xPos + PADDLEWIDTH){
    dy = -dy;
    dx -= player.currentVel;  
    if(dy > 0)
      dy += 0.5;
    else if(dy < 0)
      dy -= 0.5;
  }  
  }

void reset(){
   xPos = SCREENX / 2;
   yPos = SCREENY / 2;
   dx = 0;
   dy = 0;
}

void resetVel(){
   dx = random(-3, 3);
   dy = random(7, 10);
}

boolean scored(Player player){
    if(player.yPos > (SCREENY / 2)){
      if(yPos > player.yPos + (PADDLEHEIGHT / 4))
        return true;
    }else{
      if(yPos < (player.yPos + (3 * (PADDLEHEIGHT / 4))))
        return true;
    }
    return false;
}

void setSpeed(int xVel, int yVel){
    dx = xVel;
    dy = yVel;
}

}