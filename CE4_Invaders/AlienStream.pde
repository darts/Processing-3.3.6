class AlienStream{
 ArrayList<Alien> alienStream;
 
 AlienStream(){
  alienStream = new ArrayList<Alien>(); 
 }

//Add wrap 
void initStream(int numOfAliens) {
  for (int index = 0; index <= numOfAliens; index++)
    alienStream.add(new Alien((index * (IMG_WIDTH + MARGIN)), STARTING_Y, (int)random(0, 2), random(0, 3)));
}    


void drawAliens() {
  for (int index = 0; index < alienStream.size(); index++)
    alienStream.get(index).draw();
}
void moveAliens() {
  for (int index = 0; index < alienStream.size(); index++)
    alienStream.get(index).move();
}
  
}