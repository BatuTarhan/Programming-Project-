import de.bezier.data.sql.*;

//FinalInts
final int SCREENY = 700;
final int SCREENX = 1000;
final color BLUE = color(27, 150, 245);
color backButtonColor = BLUE;
color backButtonTextColor = color(255);

// Event Constants
final int EVENT_BUTTON1 = 1;
final int EVENT_BUTTON2 = 2;
final int EVENT_BUTTON3 = 3;
final int EVENT_BUTTON4 = 4;
final int EVENT_FOR = 5;
final int EVENT_BACK = 6;
final int EVENT_TABLE = 7;
final int EVENT_DISTANCE = 8;
final int EVENT_BAR = 9;
final int EVENT_PIE = 10;
final int EVENT_HOME = 11;
final int EVENT_LINE = 12;
final int EVENT_SORT = 13;
final int EVENT_LINE_SEARCH = 14;
final int EVENT_LINE_SEARCH_2 = 15;
final int EVENT_HEAT_MAP = 16;
final int EVENT_MAP = 17;
final int EVENT_CLOCK = 18;
final int EVENT_BOARD = 19;
final int EVENT_RADIALBAR = 20;


BarChart bc;
RadialBarChart rbc;
BufferedReader br, brA;
String line;
Table table;
ArrayList<Flight> flightData = new ArrayList();
HashMap<String, String> airlines, locs;
PImage plane, usa, bar, heat, plane2, clock, tableImg, usatran, takeOff, landing, airport, airplane, map, island;
PFont font, avenir, avenir15, avenir40, basic;
;

//Initial//
MySQL mysql;
Search search, searchLine, searchBoard;
PieChart pieCharts;
HeatMap heatMapObject;
Distance distance;
Map maps;
Clock clocks;
SQLWrapper sql;
Dropdown dropdown, sortDrop, lineDrop;
ResultsHelper rHelper, resultsHelperBoard;
Nav tableNav, distanceNav, barNav, pieNav, lineNav, heatMapNav, mapNav, clockNav, boardNav, radialBarNav;
Home home;
LineChart lineChart;
HomeHero homeHero;
Board board;
//Slider slider;

// Screens
Screen searchScreen, mainScreen, currentScreen, lineScreen, boardScreen, pieScreen, heatScreen, mapScreen, clockScreen, distanceScreen, barScreen, radialBarScreen;
int numberOfFlights;

boolean barFlag = false;
boolean radialBarFlag = false;

void setup() {
  size(1000, 700);
  background(0);
  bc = new BarChart();
  rbc = new RadialBarChart();
  br = createReader("data/flights_full.csv");
    try {
    br.readLine();
  }
  catch(IOException e) {
    e.printStackTrace();
    line = null;
  }

  //Fonts//
  font = loadFont("Menlo-Regular-15.vlw");
  textFont(font);
  avenir = loadFont("Avenir-Heavy-48.vlw");
  avenir15 = loadFont("Avenir-Book-15.vlw");
  avenir40 = loadFont("Avenir-Book-40.vlw");
  basic = loadFont("TrebuchetMS-Bold-30.vlw");

  //Images//
  plane = loadImage("plane.png");
  plane2 = loadImage("p2.png");
  usa = loadImage("usa_s.png");
  bar = loadImage("bar.png");
  heat = loadImage("heat2.png");
  tableImg = loadImage("table.png");
  usatran = loadImage("usatran.png");
  takeOff = loadImage("TakeOff.png");
  landing = loadImage("Landing.png");
  airport = loadImage("Airport.png");
  airplane = loadImage("Airplane.png");
  island = loadImage("Island.png");
  map = loadImage("map.png");
  clock = loadImage("clock.png");


  // SQL Setup
  String host = "localhost";
  String user = "root";
  String pass = "max06iKe"; // Replace with your password
  String database = "progproj";
  mysql = new MySQL(this, host+":3306", database, user, pass);
  if (mysql.connect())
  {
    println("Connection established");
  }

  locs = new HashMap();
  brA = createReader("data/locs.csv");
  try {
    while ((line = brA.readLine()) != null) {
      String[] d = split(line, ',');
      locs.put(d[0], d[1]+"/"+d[2]);
    }
  }
  catch(IOException ie) {
    ie.printStackTrace();
  }

  sql = new SQLWrapper(mysql, "flights_all");
  home = new Home(20, 8, 100, 35, EVENT_HOME, BLUE);

  /* Line Chart Screen */
  lineDrop = new Dropdown(150, 53, 190, 50, EVENT_BUTTON4);
  lineDrop.addItem("All", "all");
  lineDrop.addItem("Airline (By Code)", "carrier");
  lineDrop.addItem("Origin State", "originState");
  lineDrop.addItem("Origin Airport", "origin");
  lineDrop.addItem("Destination State", "destState");
  lineDrop.addItem("Destination Airport", "dest");
  searchLine = new Search(150, 20, EVENT_LINE_SEARCH_2, EVENT_LINE_SEARCH, sql, lineDrop);
  lineChart = new LineChart(85, 600, 900, 450, 100);
  lineScreen = new Screen(color(255));
  lineScreen.addWidget(lineChart);
  lineScreen.addWidget(home);
  lineScreen.addWidget(searchLine);

  /* Main Screen */
  tableNav = new Nav(50, 130, "Table", 900, 150, EVENT_TABLE, BLUE, color(255), 5, tableImg);
  distanceNav = new Nav(50, 290, "Distance Checker", 900, 150, EVENT_DISTANCE, BLUE, color(255), 5, plane);
  barNav = new Nav(50, 450, "Bar Charts", 900, 150, EVENT_BAR, BLUE, color(255), 5, bar);
  pieNav = new Nav(50, 610, "Pie Charts", 900, 150, EVENT_PIE, BLUE, color(255), 5, plane);
  lineNav = new Nav(50, 770, "Line Charts", 900, 150, EVENT_LINE, BLUE, color(255), 5, plane);
  heatMapNav = new Nav(50, 930, "Heat Map", 900, 150, EVENT_HEAT_MAP, BLUE, color(255), 5, heat);
  mapNav = new Nav(50, 1090, "Flights by State Map", 900, 150, EVENT_MAP, BLUE, color(255), 5, usa);
  clockNav = new Nav(50, 1250, "Clock", 900, 150, EVENT_CLOCK, BLUE, color(255), 5, clock);
  boardNav = new Nav(50, 1410, "Airport Board", 900, 150, EVENT_BOARD, BLUE, color(255), 5, plane);
  radialBarNav = new Nav(50, 1570, "Radial Bar Chart", 900, 150, EVENT_RADIALBAR, BLUE, color(255), 5, bar);

  homeHero = new HomeHero(0, 0, 0, 0);
  mainScreen = new Screen(color(255), height+500, 100);
  mainScreen.addWidget(tableNav);
  mainScreen.addWidget(distanceNav);
  mainScreen.addWidget(barNav);
  mainScreen.addWidget(pieNav);
  mainScreen.addWidget(lineNav);
  mainScreen.addWidget(heatMapNav);
  mainScreen.addWidget(mapNav);
  mainScreen.addWidget(clockNav);
  mainScreen.addWidget(boardNav);
  mainScreen.addWidget(homeHero);
  mainScreen.addWidget(radialBarNav);
  currentScreen = mainScreen;

  /* BoardScreen */
  board = new Board();
  searchBoard = new Search(110, 67, EVENT_BUTTON1, EVENT_BUTTON2, sql, 12, avenir40, 255);
  resultsHelperBoard = new ResultsHelper(50, 645, 900, 100, searchBoard, EVENT_FOR, EVENT_BACK, 255);
  boardScreen = new Screen(color(0));
  boardScreen.addWidget(board);
  boardScreen.addWidget(home);
  boardScreen.addWidget(searchBoard);
  boardScreen.addWidget(resultsHelperBoard);

  //Distance Screen
  distance = new Distance();
  distanceScreen = new Screen(color(0));
  distanceScreen.addWidget(distance);
  distanceScreen.addWidget(home);

  //Clock Screen
  clocks = new Clock();
  clockScreen = new Screen(color(0));
  clockScreen.addWidget(clocks);
  clockScreen.addWidget(home);
  //rHelper = new ResultsHelper(50, 645, 900, 100, clockSearch, EVENT_FOR, EVENT_BACK);
  //clockScreen.addWidget(resultsHelperBoard);
  //currentScreen = clockScreen;

  //Map Screen
  maps = new Map();
  mapScreen = new Screen(color(0));
  mapScreen.addWidget(maps);
  mapScreen.addWidget(home);

  /* Table Screen */
  sortDrop = new Dropdown(220, 110, 360, 50, EVENT_SORT);
  sortDrop.addItem("All", "all");
  sortDrop.addItem("Destination", "dest");
  sortDrop.addItem("Scheduled Departure (Earliest-Latest)", "scheduleDep");
  sortDrop.addItem("Scheduled Departure (Latest-Earliest)", "scheduleDep DESC");
  sortDrop.addItem("Scheduled Arrival (Earliest-Latest)", "scheduleArr");
  sortDrop.addItem("Scheduled Arrival (Latest-Earliest)", "scheduleArr DESC");
  sortDrop.addItem("Actual Departure (Earliest-Latest)", "actualDep");
  sortDrop.addItem("Actual Departure (Latest-Earliest)", "actualDep DESC");
  sortDrop.addItem("Actual Arrival (Earliest-Latest)", "actualArr");
  sortDrop.addItem("Actual Arrival (Latest-Earliest)", "actualArr DESC");
  sortDrop.addItem("Lateness", "lateness");
  dropdown = new Dropdown(150, 53, 190, 50, EVENT_BUTTON4);
  dropdown.addItem("Origin State", "originState");
  dropdown.addItem("Origin Airport", "origin");
  dropdown.addItem("Destination State", "destState");
  dropdown.addItem("Destination Airport", "dest");
  search = new Search(150, 20, EVENT_BUTTON1, EVENT_BUTTON2, sql, dropdown, sortDrop, true);
  table = new Table(50, 170);
  table.setRows(sql.getWithFilter("originState", "NY", 0, 5));
  rHelper = new ResultsHelper(50, 645, 900, 100, search, EVENT_FOR, EVENT_BACK);
  searchScreen = new Screen(color(255));
  searchScreen.addWidget(table);
  searchScreen.addWidget(rHelper);
  searchScreen.addWidget(home);
  searchScreen.addWidget(search);
  
  // Bar chart screen
  barScreen = new Screen(color(255));
  barScreen.addWidget(home);
  
  // Radial bar chart screen
  radialBarScreen = new Screen(color(255));
  radialBarScreen.addWidget(home);

  /* Pie Chart Screen */
  try {
    while ((line = br.readLine()) != null) {
      flightData.add(new Flight(line));
      numberOfFlights++;
    }
  }
  catch(IOException ie) {
    ie.printStackTrace();
  }
  brA = createReader("data/airlines.csv");
  airlines = new HashMap();
  try {
    while ((line = brA.readLine()) != null) {
      String[] d = split(line, ',');
      if (d[3] != "") airlines.put(d[3].replace("\"", ""), d[1].replace("\"", ""));
    }
  }
  catch(IOException ie) {
    ie.printStackTrace();
  }
  pieCharts = new PieChart(numberOfFlights);
  pieScreen = new Screen(0);
  pieScreen.addWidget(pieCharts);
  pieScreen.addWidget(home);

  /* Heat Map Screen */
  heatMapObject = new HeatMap();
  heatScreen = new Screen(0);
  heatScreen.addWidget(heatMapObject);
  heatScreen.addWidget(home);
  

}

int x = 700;

void draw() {
  background(0);
  if (x < -770) x = 1110;
  currentScreen.draw();

  if (barFlag) {
    bc.calculate(flightData);
    bc.drawScale(250);
    bc.draw(250);
  } else if (radialBarFlag) {
    rbc.calculateDelay(flightData);
    rbc.calculateAvrg(flightData);
    rbc.fillColors();
    rbc.draw();
  }
}

void mouseDragged()
{
  currentScreen.mouseDragged();
  clocks.mouseDragged();
}

void mousePressed() {
  distance.mousePressed();
  maps.mousePressed();
  clocks.mousePressed();
  
  //Main Screen Buttons
  int event = currentScreen.getEvent();
  switch (event)
  {
  case EVENT_BUTTON1:
    if (currentScreen == boardScreen) searchBoard.toggleFocus();
    else search.toggleFocus();
    break;
  case EVENT_BUTTON2:
    ArrayList<DataPoint> a;
    if (currentScreen == boardScreen)
    {
      a = searchBoard.search(false);
      if (a.size() > 0) board.updateBoard(a);
    } else
    {
      a = search.search(true);
      table.setRows(a);
    }
    break;
  case EVENT_BUTTON4:
    dropdown.toggleFocus();
    break;
  case EVENT_FOR:
    if (currentScreen == boardScreen)
    {
      searchBoard.incrementSearch(12);
      a = searchBoard.search(false);
      if (a.size() > 0) board.updateBoard(a);
    } else rHelper.increaseSearch(table);
    break;
  case EVENT_BACK:
    if (currentScreen == boardScreen)
    {
      searchBoard.decrementSearch(12);
      a = searchBoard.search(false);
      if (a.size() > 0) board.updateBoard(a);
    }
    rHelper.decreaseSearch(table);
    break;
  case EVENT_TABLE:
    currentScreen = searchScreen;
    break;
  case EVENT_LINE:
    lineChart.settingUp("originState", "WY", "Origin State");
    currentScreen = lineScreen;
    break;
  case EVENT_HOME:
    barFlag = false;
    radialBarFlag = false;
    currentScreen = mainScreen;
    break;
  case EVENT_BOARD:
    currentScreen = boardScreen;
    break;
  case EVENT_DISTANCE:
    currentScreen = distanceScreen;
    break;
  case EVENT_MAP:
    currentScreen = mapScreen;
    break;
  case EVENT_LINE_SEARCH:
    String tmpFilter = searchLine.filter();
    String tmpQuery = searchLine.queryString();
    String tmpDisplay = searchLine.getDisplayValue();
    lineChart.settingUp(tmpFilter, tmpQuery, tmpDisplay);
    break;
  case EVENT_LINE_SEARCH_2:
    searchLine.toggleFocus();
    break;
  case EVENT_PIE:
    currentScreen = pieScreen;
    break;
  case EVENT_CLOCK:
    currentScreen = clockScreen;
    break;
  case EVENT_HEAT_MAP:
    currentScreen = heatScreen;
    break;
  case EVENT_BAR:
    barFlag = true;
    currentScreen = barScreen;
    break;
  case EVENT_RADIALBAR:
    radialBarFlag = true;
    currentScreen = radialBarScreen;
    break;
  default:
    break;
  }
}

void keyPressed()
{
  search.keyPressed();
  searchLine.keyPressed();
  searchBoard.keyPressed();
  distance.keyPressed();
  clocks.keyPressed();
}

public class HomeHero extends Widget
{
  HomeHero(int x, int y, int width, int height)
  {
    super(x, y, width, height);
  }

  @Override
    public void draw()
  {
    noStroke();
    fill(BLUE);
    rect(0, 0, width, 100);
    stroke(255);
    line(x+240, 50, x+260, 50);
    line(x+260, 50, x+300, 5);
    line(x+260, 50, x+300, 95);
    image(plane2, x, 5, 250, 90);
    fill(255);
    rect(x+300, 5, 400, 90);
    fill(BLUE);
    textFont(avenir);
    text("CSU11013", x+310, 65);
    x -= 3;
  }
}
