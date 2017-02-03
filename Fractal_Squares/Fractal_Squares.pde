/*
Written by Luke Wetherbee and Rohan Dev Jha

To run, you need to install the Sound Library made by Processing Inc.
You will also need to change the location of the song to a song you
have downloaded. You also might need to increase the maximum available 
memory on some sketches.

*/ 


//Initializes visuals variables
float angle;
float jitter;
float time;
ArrayList<Square> squares;
//camera movement
float xEye = width/2;
float yEye = height/2;
float dX = 5;
float dY = 5;
boolean cameraMove = false;    //If true, the camera if moving

//___________music stuff____________
import processing.sound.*;
SoundFile file;
FFT fft;
int bands = 128;
BucketAnalyzer ba;
float devsAboveMean;


void setup() {
  //fullScreen();               //fullScreen() doesn't allow the camera to move
  size(1440, 900, P3D); 
  noStroke();
  rectMode(CENTER);
   
  file = new SoundFile(this, "/Users/lukewetherbee1/Music/iTunes/iTunes Media/Music/Chase & Status/Unknown Album/Pressure ft. Major Lazer.mp3");
  file.play();
  
  fft = new FFT(this, bands);
  fft.input(file);
  
  ArrayList<Integer> buckets = new ArrayList<Integer>();
  buckets.add(0);
  
  // Vals for A Milli -> 0.2316, 0.0544
  // vals for pressure -> 0.152, 0.0404
  ba = new BucketAnalyzer(fft, buckets, 0.152, 0.0404); 
  
  //Square generation using recursion
  squares = new ArrayList<Square>();
  createSquareList();
  
  //This sets the camera location as the default, but also allows it to be manipulated inside the draw method
  camera(width/2, height/2, (height/2.0) / tan(PI*30.0 / 180.0) + 200, width/2.0, height/2.0, 0, 0, 1, 0);
  
}

void draw() {
  time += .01;
  background(0);
  
  devsAboveMean = ba.getDevsAboveMean();
  
  if (devsAboveMean > 45 || cameraMove)
  {
    cameraMove = true;
    //Camera stuff
    if (xEye < 5 || xEye > width - 5)
      dX *= -1;
    if (yEye < 5 || yEye > height - 5)
      dY *= -1;
    xEye += dX;
    yEye += dY;
    camera(xEye, yEye, (height/2.0) / tan(PI*30.0 / 180.0) + 200, width/2.0, height/2.0, 0, 0, 1, 0);
  }

  for (int i = 0; i < squares.size(); i++)
  {
    squares.get(i).drawSquare(time,  color (0, 255, 0), devsAboveMean);
  }
    
}

//Uses recursion to generate list of squares
void createSquareList()
{
  float x = width/2;
  float y = height/2;
  float s = 180;
  squares.add(new Square(x, y, s));
  createSubList(x, y, s, 2);
}

void createSubList(float x1, float y1, float s1, int layer)
{

    squares.add(new Square(x1 - width/pow(2,layer), y1 - height/pow(2,layer), s1/3));
    squares.add(new Square(x1 + width/pow(2,layer), y1 - height/pow(2,layer), s1/3));
    squares.add(new Square(x1 - width/pow(2,layer), y1 + height/pow(2,layer), s1/3));
    squares.add(new Square(x1 + width/pow(2,layer), y1 + height/pow(2,layer), s1/3));
    
    
    
  if (layer < 7)
  {
    createSubList(x1 - width/pow(2,layer), y1 - height/pow(2,layer), s1/2, layer + 1);
    createSubList(x1 + width/pow(2,layer), y1 - height/pow(2,layer), s1/2, layer + 1);
    createSubList(x1 - width/pow(2,layer), y1 + height/pow(2,layer), s1/2, layer + 1);
    createSubList(x1 + width/pow(2,layer), y1 + height/pow(2,layer), s1/2, layer + 1);
  }

  
  
}