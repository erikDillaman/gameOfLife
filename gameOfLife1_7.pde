/***********************************************************
 *                                                          *
 *    Game of Life, ver 1.7                                 *
 *                          Erik Dillaman                   *
 *                                                          *
 ***********************************************************/

int CELL_SCL = 2;   // Scale of the cells in game.  Must be > 0
int GRID_SCL = 600;  // Width and height of the grid
int BOTTOM_UI = 150;
int generation = 0;
int maxGen = -1;
ArrayList<Grid> grids;
Grid grid, gridCopy;

void setup()
{
  while (GRID_SCL % CELL_SCL != 0)
  {
    GRID_SCL++;
  }
  surface.setSize(GRID_SCL, GRID_SCL);
  grids = new ArrayList<Grid>();
  grid = new Grid(GRID_SCL/CELL_SCL, GRID_SCL/CELL_SCL, generation, CELL_SCL);
  //noLoop();
}

void draw()
{
  noStroke();

  for (int y = 0; y < GRID_SCL/CELL_SCL; y++) {
    for (int x = 0; x < GRID_SCL/CELL_SCL; x++) {
      grid.updateNeighborhood(x, y);
    }
  }
  for (int y = 0; y < GRID_SCL/CELL_SCL; y++) {
    for (int x = 0; x < GRID_SCL/CELL_SCL; x++) {
      grid.updateState(x, y);
      grid.grid[x][y].addAge();
    }
  }


  grid.drawGrid();

  if (maxGen < generation) maxGen = generation;

  //println("Generation: " + generation + "   maxGen: " + maxGen);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      generation++;
      if (generation > maxGen) { 
        grids.add(grid);
        gridCopy = new Grid(grid);
        grid = gridCopy;
      }
      redraw();
    } else if (keyCode == LEFT && generation > 0) {
      generation--;
      grid = grids.get(generation);
      redraw();
    }
  }
}

void mousePressed()
{
  int x = mouseX/CELL_SCL;
  int y = mouseY/CELL_SCL;
  println("X: " + x + "  Y: " + y + "  N: "+grid.grid[x][y].neighbors+"  S: "+grid.grid[x][y].state);

  int total = 0;

  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      total += grid.grid[Math.floorMod((x+j), GRID_SCL/CELL_SCL)][Math.floorMod((y+i), GRID_SCL/CELL_SCL)].state;
      println(Math.floorMod((x+j), GRID_SCL/CELL_SCL)+", "+Math.floorMod((y+i), GRID_SCL/CELL_SCL)+": "+total);
    }
  }
}
