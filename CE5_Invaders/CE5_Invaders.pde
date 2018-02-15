import processing.sound.*;
AudioDevice myAudioServer;

Player thePlayer;
AlienStream alienStream;
BulletStream bulletStream;
Bullet bullet;
ShieldArray shieldArray;
BombArray bombArray;
boolean gameOver;
PFont gameOverFont;
SoundFile gameOverClip;

void settings() {
  size(SCREEN_X, SCREEN_Y);
}

void setup() {
  gameOverFont = loadFont("Impact-170.vlw");
  textFont(gameOverFont);
  textAlign(CENTER);
  initGame();
  gameOverClip = new SoundFile(this, "die.wav");
}


void draw() { 
  if (!gameOver) {
    background(255);
    bombArray.move();
    bombArray.draw();
    thePlayer.move(mouseX);
    thePlayer.draw();
    shieldArray.draw(bulletStream, bombArray);
    bulletStream.moveBullets();
    bulletStream.drawBullets();
    bulletStream.delOutSide();
    alienStream.moveAliens(bulletStream, bombArray, this);
    alienStream.drawAliens();
    playerHit();
  }else{
    background(255);
    thePlayer.draw();
    text("Game Over", SCREEN_X / 2, SCREEN_Y / 2);
  }
}

//If the mouse is pressed and the game is in progress, a new bullet is created/tries to create new bullet.
//If game is over, resets the game when the mouse is pressed.
void mousePressed() {
  if (gameOver) {
    initGame();
  } else {
    bulletStream.addBullet(thePlayer.getX(), this);
  }
}

//If the player is hit this deletes all objects other than the player.
void playerHit() {
  if (bombArray.hitPlayer(thePlayer)) {
    bulletStream = null;
    alienStream = null;
    bombArray = null;
    shieldArray = null;
    thePlayer.explode();
    gameOver = true;
    gameOverClip.play();
  }
}

//Starts a new game. Resets shields, player, bullets, bombs and creates a new collection of each.
void initGame() {
  gameOver = false;
  bombArray = new BombArray();
  shieldArray = new ShieldArray(SHIELD_X, SHIELD_Y, SHIELD_MARGIN, SHIELD_COUNT, this);
  alienStream = new AlienStream();
  alienStream.initStream(NUM_OF_ALIENS,this);
  thePlayer = new Player(SCREEN_Y - (PLAYER_Y + 20));
  bulletStream = new BulletStream();
}