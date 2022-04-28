import toxi.geom.*;

float r=35;
//DECLARE
ArrayList ballCollection;
void setup() {
  size(600, 600);
  surface.setTitle("іїыіs");
  surface.setResizable(true);
  smooth();
//  noStroke();
  fill(#8FFCC6, 127);

  //INITIALIZE
  ballCollection = new ArrayList();
  for (int i=0; i<100; i++) {
    Vec3D origin = new Vec3D(random(0,width),random(0,height-r),0);
    Ball myBall = new Ball(origin);
    ballCollection.add(myBall);
  }
}

void draw() {
  background(255);

  //CALL FUNCIONALITY
  for ( int i=0; i<ballCollection.size(); i++) {
    Ball MB = (Ball) ballCollection.get(i);
    MB.run();
  }
}
