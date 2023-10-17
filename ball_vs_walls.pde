

class Transform{
  float x, y;
  float vel;
  float scaleX, scaleY;
  float radio;
  float velX, velY, gravity;
  boolean chocaX, chocaY;
  
  Transform(){
    x = 0;
    y = 0;
    vel = 0;
    scaleX = 0;
    scaleY = 0;
    radio = 0;
    velX = 0;
    velY = 0;
    gravity = 9.8;
    
    chocaX = false;
    chocaY = false;
  }
  
  void MueveX(){
    if(x >= width || x <= 0){
      velX *= -1;
    }
    
    x += velX;
  }
  
  void MueveY(){
    if(y >= height || y <= 0){
      velY *= -1;
    }
    
    y += velY;
  }
  
  void MueveXY(){
    MueveX();
    MueveY();
  }
  
  void SetColX(){
    velX *= -1;
  }
  
  void SetColY(){
    velY *= -1;
  }
}

class Ball extends Transform{
  int r,g,b;
  
  Ball(float x,float y,float rad){
    this.x = x;
    this.y = y;
    radio = rad;
    
    r = (int) random(255);
    g = (int) random(255);
    b = (int) random(255);
  }
  
  void Draw(){
    MueveXY();
    fill(r,g,b);
    circle(x,y,radio);
  }
  
  void SetVel(float x,float y){
    velX = x;
    velY = y;
  }
  
  // Metodo que se encarga de medir la distancia entre esta y otra pelota de la misma clase
  float CollisionBalls(Ball b2){
    float deltaX = x - b2.x;
    float deltaY = y - b2.y;
    float quad = (deltaX * deltaX) + (deltaY * deltaY);
    float raiz = sqrt(quad);
    return raiz;
  }
  
  void SetRGB(int r,int g,int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  void CollisionBWall(Transform wall){
    // Calcula los bordes del objeto
    float left = x;
    float right = x + radio/2;
    float top = y;
    float bottom = y + radio/2;
  
    // Calcula los bordes del muro
    float wallLeft = wall.x;
    float wallRight = wall.x + wall.scaleX;
    float wallTop = wall.y;
    float wallBottom = wall.y + wall.scaleY;
  
    // Verifica la colisión
    if (right > wallLeft && left < wallRight && bottom > wallTop && top < wallBottom) {
      // Colisión detectada, cambia la dirección del movimiento
      velX *= -1;
      velY *= -1;
    }
  }
}

class Muro extends Transform{
  int r,g,b;
  
  Muro(float x,float y,float ancho,float largo){
    this.x = x;
    this.y = y;
    scaleX = ancho;
    scaleY = largo;
    
    r = (int) random(255);
    g = (int) random(255);
    b = (int) random(255);
    
    velX = random(-10,10);
    velY = random(-10,10);
  }
  
  void Draw(){
    //MueveXY();
    fill(r,g,b);
    rect(x,y,scaleX,scaleY);
  }
  
  void SetRGB(int r,int g,int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
}

Ball[] balls = new Ball[1];
Muro[] walls = new Muro[10];

void setup(){
  size(1600,800);
  
  for(int i=0;i<walls.length;i++){
    walls[i] = new Muro(random(width),random(height),random(20,300),random(20,300));
  }
  
  for(int i=0;i<balls.length;i++){
    balls[i] = new Ball(random(width),random(height),random(20,80));
    balls[i].SetVel(random(-25,25),random(-25,25));
  }
}

void draw(){
  background(220);
  
  for(int i=0;i<balls.length;i++){
    balls[i].Draw();
  }
  
  for(int i=0;i<walls.length;i++){
    walls[i].Draw();
    for(int j=0;j<balls.length;j++){
      balls[j].CollisionBWall(walls[i]);
    }
  }
 
}
