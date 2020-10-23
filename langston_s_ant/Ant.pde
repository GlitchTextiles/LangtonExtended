public class Ant { 
  private int x;
  private int y;
  private int orientation; // 0 = UP, 1 = RIGHT, 2 = DOWN, 3 = LEFT 

  public Ant (int _x, int _y, int _orientation) {
    this.x = _x;
    this.y = _y;  
    this.orientation = _orientation;
  }

  public Ant () {
    this.x = int(random(width));
    this.y = int(random(height));  
    this.orientation = int(random(4));
  }


  public void update(int[] _states) {
    
    int state = _states[this.y*width+this.x];
    int rotation = rules[state] & 1;

    if (rotation == 1) {
      this.orientation++;
    } else if (rotation == 0){
      this.orientation--;
    } 

    this.orientation = (this.orientation + 4) % 4;

    switch(this.orientation) {
    case 0:
      this.y--;
      break;
    case 1:
      this.x++;
      break;
    case 2:
      this.y++;
      break;
    case 3:
      this.x--;
      break;
    }

    // wrap around
    this.x = (this.x + width) % width;
    this.y = (this.y + height) % height;
  }
  
  public int getX(){
    return this.x;
  }
  
  public int getY(){
    return this.y;
  }
  
  public int getOrientation(){
    return this.orientation;
  }
  
  public void setX(int _x){
    this.x = _x;
  }
  
  public void setY(int _y){
    this.y = _y;
  }
  
  public void setOrientation(int _orientation){
    this.orientation = _orientation;
  }
  
}
