Player thePlayer;
Ball theBall;
Player theComputer;
int difficultyLevel;
boolean gamePaused;
PFont scoreFont;
PFont gameOverFont;
boolean gameOver;
PFont levelFont;

void settings(){
  size(SCREENX, SCREENY);
}

void setup(){
  noStroke();
  theComputer = new Player(MARGIN);
  thePlayer = new Player(SCREENY - MARGIN - PADDLEHEIGHT);
  theBall = new Ball();
  frameRate(60);
  //--------------------------
  difficultyLevel = 1;
  //-------------------------
  gamePaused = true;
  scoreFont = loadFont("MicrosoftTaiLe-130.vlw");
  gameOverFont = loadFont("MicrosoftTaiLe-170.vlw");
  levelFont = loadFont("MicrosoftTaiLe-30.vlw");
  gameOver = false;
}

void mousePressed(){
  if(gamePaused){
    if(gameOver){
      gameOver = false;
    }else{
      gamePaused = false;
      theBall.resetVel();
    }
  }
}

void draw(){
  if(!gameOver){
     dispScore(thePlayer, theComputer);
     fill(0, 0, 0, 80);
     rect(0, 0, SCREENX, SCREENY);
     theComputer.track(theBall, difficultyLevel);
     thePlayer.move(mouseX);
     theBall.move();
     theBall.collide(thePlayer, theComputer);
     showDifficulty();
     theComputer.draw();
     thePlayer.draw();
     theBall.draw();
     goalScored(thePlayer, theComputer);
     checkGameOver(thePlayer, theComputer);
  }
}

void showDifficulty(){
  fill(255);
  textFont(levelFont);
  text("Difficulty: " + difficultyLevel, 100, 100);
  text("Speed: " + (int)abs(theBall.dy), 100, 140);
}

void goalScored(Player thePlayer, Player theComputer){
   if(theBall.scored(thePlayer) || theBall.scored(theComputer)){
   if(theBall.scored(thePlayer))
     thePlayer.loseLife();
   else{
     theComputer.loseLife();
     //---------------------
     difficultyLevel++; 
     //-----------------------
   }
   theBall.reset();
   gamePaused = true;
 }
}

void dispScore(Player thePlayer, Player theComputer){
 textFont(scoreFont);
 fill(255);
 text(thePlayer.lives, (SCREENX / 2) - 35, 2 * (SCREENY / 3) + 40 );
 text(theComputer.lives, (SCREENX / 2) - 35, (SCREENY / 3) + 40);
}

void checkGameOver(Player thePlayer, Player theComputer){
   if(thePlayer.lives == 0 || theComputer.lives == 0){
      gameOver();
  }
}

void gameOver(){
  theBall.reset();
  gamePaused = true;
  gameOver = true;
  textFont(gameOverFont);
  fill(255);
  background(0);
  if(thePlayer.lives == 0){
   text("Hard luck, try again?", 200, 600); 
  }else{
   text("You win, play again?", 200, 600); 
  }
  thePlayer.resetLives();
  theComputer.resetLives();
  difficultyLevel = 1;
}