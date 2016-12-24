float time = 0; 
float theta = 0;
PImage hrmbe1;
PImage bg;
PImage hrmbe2;
PImage emoji1;
PImage emoji2;
PImage emoji3;
PImage emoji4;
float harambeIMissYouSoMuchPlsSmileUponMeOneMoreTime = 15;

ArrayList<Particle> particles = new ArrayList<Particle>();


//Music stuff
import processing.sound.*;
SoundFile file;
FFT fft;
int bands = 1024;
BucketAnalyzer ba;
float devsAboveMean0;
float devsAboveMean1;
float devsAboveMean2;
float devsAboveMean3;
float devsAboveMean4;
float devsAboveMean5;
ArrayList<BucketAnalyzer> bas;

void setup() {
  fullScreen();
  bg = loadImage("BushDidHarambe.jpg");
  frameRate(60);
  rectMode(CENTER);
  
  file = new SoundFile(this, "/Users/lukewetherbee1/Music/iTunes/iTunes Media/Music/Unknown Artist/Unknown Album/Young Thug - Harambe [Official Audio].mp3");
  delay(10);
  file.play();
  delay(10);
  fft = new FFT(this, bands);
  fft.input(file);
  bas = new ArrayList<BucketAnalyzer>();
  for (int i = 0; i < 6; i++)
  {
    ArrayList<Integer> buckets = new ArrayList<Integer>();
    for (int j = i * 25; j < (i + 1) * 25; j++)
    {
      buckets.add(j);
    }
    bas.add(new BucketAnalyzer(fft, buckets, bands));
  }
  
  //Vals for all we do - Kaytra
  bas.get(0).set(1.2560458, 0.5565917);
  /*bas.get(1).set(0.25963914, 0.06601972);
  bas.get(2).set(0.12765302, 0.021797344);
  bas.get(3).set(0.09016249, 0.015026064);
  bas.get(4).set(0.08142285, 0.016922515);
  bas.get(5).set(0.07523557, 0.02082847);*/
  
  hrmbe1 = loadImage("DOFH.jpg");
  hrmbe2 = loadImage("Harambe.jpg");
  emoji1 = loadImage("emoji1.jpg");
  emoji2 = loadImage("emoji2.jpg");
  emoji3 = loadImage("emoji3.jpg");
  emoji4 = loadImage("emoji4.jpg");
  

}


void draw() {
  background(bg);
  rectMode(CENTER);
  time += 1;
  devsAboveMean0 = bas.get(0).getDevsAboveMean();
  //devsAboveMean1 = bas.get(1).getDevsAboveMean();
  //devsAboveMean2 = bas.get(2).getDevsAboveMean();
  //devsAboveMean3 = bas.get(3).getDevsAboveMean();
  //devsAboveMean4 = bas.get(4).getDevsAboveMean();
  //devsAboveMean5 = bas.get(5).getDevsAboveMean();
  
  if (devsAboveMean0 > 4)
  {
    harambeIMissYouSoMuchPlsSmileUponMeOneMoreTime = 15;
  }
  else
  {
    harambeIMissYouSoMuchPlsSmileUponMeOneMoreTime = 25;
  }
    
  if (time % harambeIMissYouSoMuchPlsSmileUponMeOneMoreTime == 0)
  { 
    particles.add(new Particle(random(20) + width/2, random(20) + height/2, random(-5, 5), random(-5, 5), hrmbe1));
  }
  else if (time % harambeIMissYouSoMuchPlsSmileUponMeOneMoreTime == 3)
  { 
    particles.add(new Particle(random(20) + width/2, random(20) + height/2, random(-5, 5), random(-5, 5), emoji1));
  }
  else if (time % harambeIMissYouSoMuchPlsSmileUponMeOneMoreTime == 6)
  {  
    particles.add(new Particle(random(20) + width/2, random(20) + height/2, random(-5, 5), random(-5, 5), emoji2));
  }
  else if (time % harambeIMissYouSoMuchPlsSmileUponMeOneMoreTime == 9)
  { 
    particles.add(new Particle(random(20) + width/2, random(20) + height/2, random(-5, 5), random(-5, 5), emoji3));
  }
  else if (time % harambeIMissYouSoMuchPlsSmileUponMeOneMoreTime == 12)
  { 
    particles.add(new Particle(random(20) + width/2, random(20) + height/2, random(-5, 5), random(-5, 5), emoji4));
  }
  
  for (int i = 0; i < particles.size(); i++)
  {
    if (particles.get(i).getX() > width || particles.get(i).getX() < 0)
    {
      particles.remove(i);
    }
    else
    {
      particles.get(i).display(devsAboveMean0);
      particles.get(i).move(devsAboveMean0);
    }
  }
  
  
  
}