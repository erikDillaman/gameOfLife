class Cell
{

  int state;
  int neighbors;
  int x, y, scale, age;

  Cell(int x, int y, int state, int scale) {
    this.x = x;
    this.y = y;
    this.state = state;
    this.scale = scale;
    neighbors = 0;
    age = 1;
  }

  void setNeighborhood(int total) {
    neighbors = total;
  }
  
  int getNeighborhood() {
    return neighbors;
  }

  int getState() {
    return state;
  }
  
  void addAge(){
    age++;  
  }

  void displayCell() {
    if (state == 0) {
      fill(255, 255, 255, age);
      rect(x, y, scale, scale);
    } else {
      fill(255-age*20, 255-age*5, 255-age*10, 100);
      rect(x, y, scale, scale);
    }
  }

  void updateState() {
    if (state == 1 && neighbors < 2){
      state = 0;
      age = 0;
    } else if (state == 1 && neighbors > 3){
      state = 0;
      age = 0;
    } else if (state == 0 && neighbors == 3) state = 1;
  }
}