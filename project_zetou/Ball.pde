
float magnitudeSep;
//float magnitudeCohesion;
//float magnitudeAlign;
class Ball {

  Vec3D loc = new Vec3D (0, 0, 0);
  Vec3D speed = new Vec3D (random(-1, 1), random(-1, 1), 0);
  Vec3D grav = new Vec3D(0, 0.2, 0);
  Vec3D acc = new Vec3D(0, 0, 0);
  Vec3D vel = new Vec3D(0, 0, 0);
  Ball(Vec3D _loc) {
    loc = _loc;
  }

  void run() {
    display();
    move();
    bounce();
    //   gravity();
    lineBetween();
    flock();
    //  updatespeed();
    folowMouse();
    //colorchange();
  }
 /* 
  void colorchange(){ 
  }*/
  
  void folowMouse() {
    if (mousePressed) {
      Vec3D target = new Vec3D(mouseX, mouseY, 0);
      Vec3D dif = target.sub(loc);
      float distance = dif.magnitude();
      dif.normalize();
      dif.scaleSelf(2);
      dif.scaleSelf(distance/2);
      acc.addSelf(dif);
    }
  }
  /*
   void updatespeed() {
   
   vel.addSelf(acc);
   vel.limit(1);
   loc.addSelf(vel);
   acc = new Vec3D();
   }*/


  void flock() {

    separate(45);
    cohesion(0.001);
    align(0.1);
  }

  void align(float magnitudeAlign) {

    Vec3D steer = new Vec3D();
    int count = 0;

    for (int i=0; i<ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.distanceTo(other.loc);
      if (distance > 0 && distance < 40) {
        steer.addSelf(other.speed);
        count++;
      }
    }
    if (count > 0) {
      steer.scaleSelf(1.0/count);
    }
    steer.scaleSelf(magnitudeAlign);
    acc.addSelf(steer);
  }

  void cohesion(float magnitudeCohesion) {
    Vec3D sum = new Vec3D();
    int count = 0;

    for (int i=0; i<ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.distanceTo(other.loc);
      if (distance > 0 && distance < 60) {

        sum.addSelf(other.loc);
        count++;
      }
    }
    if (count > 0) {
      sum.scaleSelf(1.0/count);
    }
    Vec3D steer = sum.sub(loc);
    steer.scaleSelf(magnitudeCohesion);
    acc.addSelf(speed);

    if (sum.magnitude() > 0) {
      steer.scaleSelf(magnitudeSep);
      acc.addSelf(steer);
    }
  }


  void separate(float magnitudeSep) {

    Vec3D steer = new Vec3D();
    int count = 0;

    for (int i=0; i<ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.distanceTo(other.loc);

      if (distance > 0 && distance < 30) {
        Vec3D diff = loc.sub(other.loc);
        diff.normalizeTo(1.0/distance); //
        steer.addSelf(diff);
        count++;
      }
    }
    if (count > 0) {
      steer.scaleSelf(1.0/count);
    }

    steer.scaleSelf(magnitudeSep);
    acc.addSelf(steer);
  }



  void lineBetween() {

    for (int i=0; i<ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.distanceTo(other.loc);

      if (distance > 0 && distance < 40) {
        stroke(255, 0, 0);
        strokeWeight(0.3);
        line(loc.x, loc.y, other.loc.x, other.loc.y);
      }
    }
  }
  
  void gravity() {  
    speed.addSelf(grav);
  }
  
  void bounce() {
    if (loc.x > width) {
      speed.x = speed.x * -1;
    }
    if (loc.x < 0) {
      speed.x = speed.x  * -1;
    }
    if (loc.y > height) {
      speed.y= speed.y * -1;
    }
    if (loc.y < 0) {
      speed.y= speed.y * -1;
    }
  }

  void move() {
    
    speed.addSelf(acc);
    speed.limit(2);
    loc.addSelf(speed);
    acc.clear();
  }

  void display() {
    stroke(255);
    ellipse(loc.x, loc.y, r, r);
  }
}
