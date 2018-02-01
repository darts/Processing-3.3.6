int xSize = 100;
int ySize = 100;
int xLoc = 0;
int yLoc = 100;
void setup(){
  size(300, 300);
  noStroke();
  fill(250, 200, 255);
}
 
void draw(){
  background(255);
  rect(xLoc++, yLoc, xSize, ySize);
  if(xLoc == 299)
    xLoc = 0;
}