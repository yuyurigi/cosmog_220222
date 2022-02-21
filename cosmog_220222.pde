import geomerative.*;
import java.util.Calendar;;

int num = 0;
int maxnum = 2000;
int dimborder = 20; //縁の太さ
int time = 0;
int sw = 3; //図形の輪郭線の太さ

Star[] stars;
                       
color[] colors = {
#ffffff, //白
#c8e7fb, //水色
#ddd5ec, //紫
#a7b0db, //青
#414874}; //紺

PShape starSvg; //星のsvg画像

// background image
PImage backImage;
PImage backImage2;

PGraphics pg;

color backColor = color(221, 228, 246); //背景色
color borderColor = color(255); //縁の色
color strokeColor = #5266ae;
// MAIN -----------------------------------------------------------

void setup() {
  size(800, 800);
  frameRate(30);

  // create stars
  stars = new Star[maxnum];

  starSvg = loadShape("star.svg");
  starSvg.disableStyle();
  shapeMode(CENTER);
  backImage = loadImage("lillie.png");
  backImage2 = loadImage("lillie2.png");
  imageMode(CENTER);
  
  RG.init(this);

  resetAll();
}

void draw() {
  background(backColor);
  tint(255,255);
  image(backImage, width/2, height/2); //リリィ
  drawWhiteBorder();
  
  for (int n=0; n<num; n++) {
    stars[n].draw();
  }
  
  time++;

  if (time == 1800) {
    saveFrame(timestamp()+"_####.png");
    resetAll();
  }
}

void mousePressed() {
  resetAll();
}

void resetAll() {  
  setPg();
  
  num=0;
  time = 0;

  makeNewStar();
  makeNewStar();
}


void makeNewStar() {
  if (num<maxnum) {
    stars[num] = new Star();
    num+=1;
  }
}

void setPg(){
  pg = createGraphics(width, height);
  pg.beginDraw();
  //pg.imageMode(CENTER);
  pg.image(backImage2, 0, 0);
  pg.noStroke();
  pg.fill(255);
  pg.rect(0, 0, width, dimborder);
  pg.rect(0, 0, dimborder, height);
  pg.rect(0, height-dimborder, width, dimborder);
  pg.rect(width-dimborder, 0, dimborder, height);
  pg.endDraw();
}

void drawWhiteBorder() {
  fill(borderColor);
  noStroke();
  rect(0, 0, width, dimborder); //縁
  rect(0, 0, dimborder, height); //縁
  rect(0, height-dimborder, width, dimborder); //縁
  rect(width-dimborder, 0, dimborder, height); //縁
}

void keyReleased() {
  if (key == 's' || key == 'S')saveFrame(timestamp()+"_####.png");
}


String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
