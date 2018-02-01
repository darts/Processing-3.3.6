class Player {
  int xPos;
  int yPos;
  color paddleColour = color(250);
  int lives = STARTINGLIVES;
  int currentVel;
  
  Player(int screenY){
    xPos = SCREENX/2;
    yPos = screenY;
  }
  
  void move(int x){
    int prevLoc = xPos;
    if(x > SCREENX - PADDLEWIDTH)
      xPos = SCREENX - PADDLEWIDTH;
     else 
       xPos = x;
    currentVel = prevLoc - xPos;
  }
   
  void loseLife(){
    lives--;
  }
  
  void resetLives(){
   lives = STARTINGLIVES; 
  }
  void draw(){
    //move(x);
    fill(paddleColour);
    rect(xPos, yPos, PADDLEWIDTH, PADDLEHEIGHT);
  }
  
  void track(Ball theBall, int trackLevel){
    int prevLoc = xPos;
    switch (trackLevel){
      case 1:
        simpleTrack(theBall, 10);
        break;
      case 2:
        simpleTrack(theBall, 15);        
        break;
      default:
        if(theBall.dy > 0)
          simpleTrack(theBall, 10);
        else
          complexTrack(theBall, 20);
    }  
    currentVel = prevLoc - xPos;
  }
  
  void simpleTrack(Ball theBall, int trackSpeed){
      for(int i = 0; i < trackSpeed; i++){
        //if(xPos <= SCREENX - PADDLEWIDTH && xPos >= 0)
          if(xPos < (theBall.xPos - (PADDLEWIDTH / 2)) && xPos < SCREENX - PADDLEWIDTH)
          xPos += DEFAULTTRACKVEL;
          else if(xPos > theBall.xPos - (PADDLEWIDTH / 2) && xPos > 0)
          xPos-= DEFAULTTRACKVEL;
       }
  }
  
  void complexTrack(Ball theBall, int trackSpeed){
    float distY = theBall.yPos - (MARGIN + PADDLEHEIGHT);
    float distX = theBall.xPos;
    float distImpact = distY - (abs(distX / theBall.dx) * abs(theBall.dy));
    float impactLoc = abs((distImpact / abs(theBall.dy)) * theBall.dx);
    if(distImpact <= (MARGIN + PADDLEHEIGHT))
      impactLoc = ((distY / abs(theBall.dy)) * theBall.dx) + theBall.xPos;
    for(int i = 0; i < trackSpeed; i++){
      if(xPos > impactLoc - (PADDLEWIDTH / 2) && xPos > 0)
        xPos -= DEFAULTTRACKVEL;
      else if(xPos < impactLoc - (PADDLEWIDTH / 2) && xPos < SCREENX - PADDLEWIDTH)
        xPos += DEFAULTTRACKVEL;
      }
    
    println(distY + " " + distY  + " " + distImpact + " " + impactLoc);
  }
}