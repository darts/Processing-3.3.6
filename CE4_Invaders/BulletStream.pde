class BulletStream { //<>//
  ArrayList<Bullet> bulletStream;
  BulletStream() {
    bulletStream = new ArrayList<Bullet>();
  }

  void moveBullets() {
    for (int index = 0; index < bulletStream.size(); index++) {
      bulletStream.get(index).move();
    }
  }

  void drawBullets() { 
    for (int index = 0; index < bulletStream.size(); index++) {
      bulletStream.get(index).draw();
    }
  }

  void addBullet(int xPos) {
    println(bulletStream.size());
    bulletStream.add(new Bullet(xPos));
  }

  void delOutSide() {
    for (int index = 0; index < bulletStream.size(); index++) {
      if (bulletStream.get(index).isOutOfRange())
        bulletStream.remove(index);
    }
  }
}