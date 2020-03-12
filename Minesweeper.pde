import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 16;
public final static int NUM_COLS = 16;
public final static int NUM_MINES = 30;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
private boolean gameOver = false;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }
    setMines();
}
public void setMines()
{
    mines = new ArrayList<MSButton>();
    while(mines.size() < NUM_MINES)
    {
        int r = (int)(Math.random() * NUM_ROWS);
        int c = (int)(Math.random() * NUM_COLS);
        if(!mines.contains(buttons[r][c]))
        {
            mines.add(buttons[r][c]);
        }
        System.out.println(r + ", " + c);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(buttons[r][c].clicked == false && buttons[r][c].isFlagged() == false && countMines(r,c) != NUM_MINES)
                return false;
        }
    }
    return true;
}
public void displayLosingMessage()
{
    buttons[NUM_ROWS/2][NUM_COLS/2-4].setLabel("G");
    buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("A");
    buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("M");
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("E");
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel(" ");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("V");
    buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("E");
    buttons[NUM_ROWS/2][NUM_COLS/2+4].setLabel("R");
}
public void displayWinningMessage()
{
    if(isWon() == true)
    {
       buttons[NUM_ROWS/2][NUM_COLS/2-4].setLabel("Y");
        buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("O");
        buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("U");
        buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel(" ");
        buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("W");
        buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("I");
        buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("N");
        buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("!"); 
    }
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS && r >= 0)
    {
        if(c < NUM_COLS && c >=0)
            return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row+1,col) && mines.contains(buttons[row+1][col]))
        numMines++;
    if(isValid(row-1,col) && mines.contains(buttons[row-1][col]))
        numMines++;
    if(isValid(row,col+1) && mines.contains(buttons[row][col+1]))
        numMines++;
    if(isValid(row,col-1) && mines.contains(buttons[row][col-1]))
        numMines++;
    if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
        numMines++;
    if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1]))
        numMines++;
    if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
        numMines++;
    if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1]))
        numMines++;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        if(gameOver == false)
        {
            clicked = true;
            if(mouseButton == RIGHT)
            {
                flagged = !flagged;
                if(!flagged)
                {
                    clicked = false;
                }
            }else if(mines.contains(this)){
                displayLosingMessage();
                gameOver = true;
            }else if(countMines(myRow,myCol) > 0){
                setLabel(countMines(myRow,myCol));
            }else{
                if(isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].clicked){
                    buttons[myRow-1][myCol-1].mousePressed();
                }
                if(isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].clicked){
                    buttons[myRow+1][myCol-1].mousePressed();
                }
                if(isValid(myRow-1,myCol+1) && !buttons[myRow-1][myCol+1].clicked){
                    buttons[myRow-1][myCol+1].mousePressed();
                }
                if(isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].clicked){
                    buttons[myRow+1][myCol+1].mousePressed();
                }
                if(isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].clicked){
                    buttons[myRow][myCol-1].mousePressed();
                }
                if(isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].clicked){
                    buttons[myRow-1][myCol].mousePressed();
                }
                if(isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].clicked){
                    buttons[myRow+1][myCol].mousePressed();
                }
                if(isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].clicked){
                    buttons[myRow][myCol+1].mousePressed();
                }
            }
        }
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
