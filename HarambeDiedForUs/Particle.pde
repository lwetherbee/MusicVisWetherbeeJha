class Particle
{

  float x;
  float y;
  float dx; 
  float dy;
  PImage iMissHarambe;
  float harambeIsLove;
  float harambeIsLife;
  
   public Particle(float x, float y, float dx, float dy, PImage iMissHarambe)
  {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.iMissHarambe = iMissHarambe;
  }
  
  void display(float devsAboveMean0)
  {
    image(iMissHarambe, x, y, 20 + max(devsAboveMean0, 7), 20 + max(devsAboveMean0, 7));
  }
  
  void move(float devsAboveMean0)
  {
    if (devsAboveMean0 > 3)
    {
      harambeIsLove = 2;
      harambeIsLife = 2;
    }
    else
    {
      harambeIsLove = 1;
      harambeIsLife = 1;
    }
    x += dx * harambeIsLove;
    y += dy * harambeIsLife;
    
  }
  
  float getX()
  {return x;}
  float get()
  {return y;}
  
}