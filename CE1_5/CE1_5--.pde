int xSize = 100;
int ySize = 100;
int xLocSqA = 0;
int yLocSqA = 75;
int xLocSqB = 199;
int yLocSqB = 175;

void setup(){
  size(300, 300);
  noStroke();
  fill(0, 0, 255);
}

void draw(){
  background(255);
  rect(xLocSqA++, yLocSqA, xSize, ySize);
  if(xLocSqA > 199)
    rect(xLocSqA - 300, yLocSqA, xSize, ySize); 
  if(xLocSqA == 299)
    xLocSqA = 0;
    
  rect(xLocSqB--, yLocSqB, xSize, ySize);
  if(xLocSqB < 0)
    rect(xLocSqB + 300, yLocSqB, xSize, ySize); 
  if(xLocSqB == -100)
    xLocSqB = 199;
   
}