class Actor{
  
  float x;
  float y;
  float l;
  float a;
  float scaleX;
  float scaleY;
  
  float groundY;
  float playerSpeedY = 0;
  boolean jumping = false;
  
  
  Actor (float x, float y, float l, float a, float scaleX, float scaleY){
    this.x = x;
    this.y = y;
    this.l = l;
    this.a = a;
    this.scaleX = scaleX;
    this.scaleY = scaleY;
  }
    
  
  void update(int inc, int stop){
   if(x<stop){
   x+=inc;
   }
  }
  
  
  void update2(int inc, int stop){
   if(x>stop){
   x-=inc;
   }
  }
  
  void update3(){
    
    y += playerSpeedY;
    if (mousePressed) {
     // y = groundY - scaleY;
      playerSpeedY = 0;
      jumping = false;
    }else {
      playerSpeedY ++;
  }
}

void pulo(){
  if(mousePressed){
    if (!jumping) {
      playerSpeedY = -10;
      jumping = true;
    }
  }
}
  
  void display(color i){
    fill(i);
    rect(x, y, l*scaleX, a*scaleY);
  }
}
