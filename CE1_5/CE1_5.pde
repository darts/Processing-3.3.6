 //<>//
int yLocA = 250;
int xLocA = 0;
int yLocB = 200;
int xLocB = 500;
int xSize = 100;
int ySize = 100;
int changeRateA = 15;
int changeRateB = 15;
void setup(){
  size(600,600); 
  fill(255, 0,0);
  frameRate(60);
}

void draw(){
  background(255);
  fill(xLocA, yLocA/2, (xLocA / (yLocB/2)));
  rect(xLocA+=2, yLocA, xSize,ySize);
  if(yLocA < 300){
    changeRateA++;
  }else if(yLocA > 300){
    changeRateA--;
  }
  yLocA += changeRateA; 
  if(xLocA > 499)
    rect(xLocA - 600, yLocA, xSize, ySize); 
  if(xLocA > 599)
    xLocA = 0;
  
  fill(xLocB, yLocB/2, (xLocB / (yLocA/2)));
  rect(xLocB-=2, yLocB, xSize, ySize);
  if(yLocB < 300){
    changeRateB++;
  }else if(yLocB > 300){
    changeRateB--;
  }
  yLocB += changeRateB; 
  if(xLocB < 99)
    rect(xLocB + 599, yLocB, xSize, ySize); 
  if(xLocB < -100)
    xLocB = 499;
  
}