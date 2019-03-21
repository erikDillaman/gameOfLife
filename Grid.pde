class Grid
{

  Cell[][] grid;
  int generation, scale, col, row;

  // Regular constructor
  Grid(int col, int row, int generation, int scale) {
    this.col = col;
    this.row = row;
    this.generation = generation;
    this.scale = scale;

    grid = new Cell[col][row];

    for (int y = 0; y < row; y++) {
      for (int x = 0; x < col; x++) {
        grid[x][y] = new Cell(x*scale, y*scale, int(random(2)), scale);
      }
    }
  }

  // Clone constructor
  Grid(Grid gridCopy) {
    col = gridCopy.col;
    row = gridCopy.row;
    generation = gridCopy.generation;
    scale = gridCopy.scale;
    
    grid = new Cell[col][row];
    arrayCopy(gridCopy.grid, grid);
    
    //for (int y = 0; y < row; y++) {
    //  for (int x = 0; x < col; x++) {
    //    grid[x][y] = new Cell(gridCopy.grid[x][y].x, gridCopy.grid[x][y].y, gridCopy.grid[x][y].state, gridCopy.grid[x][y].state);
    //  }
    //}
  }

  void updateNeighborhood(int x, int y) {
    int total = 0;
    
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        total += grid[Math.floorMod((x+j), col)][Math.floorMod((y+i), row)].state;
      }
    }
    total -= grid[x][y].state;
    grid[x][y].setNeighborhood(total);
  }

  void updateState(int x, int y) {
    grid[x][y].updateState();
  }

  void drawGrid() {
    for (int x = 0; x < col; x++) {
      for (int y = 0; y < row; y++) {  
        grid[x][y].displayCell();
      }
    }
  }
}