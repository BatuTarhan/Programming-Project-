/**
 * Class for implementing pie charts.
 *
 * @author  Kitty Joyce
 */

public class PieChart extends Widget {
  
  ArrayList <Integer> cancelledList = new ArrayList();
  ArrayList <Integer> divertedList = new ArrayList();
  ArrayList <String> dateList = new ArrayList();
  int numberOfFlights;
  boolean doOnce=true;
  int numberCancelled, numberDiverted;
  int[] countOfEachDay;

  PieChart(int numberOfFlights)
  {
    super();
    this.numberOfFlights = numberOfFlights-1;
  }
   
  public void getData(ArrayList <Flight> flightData) {

    for (Flight flightObj : flightData) {
       cancelledList.add(flightObj.Cancelled);
       divertedList.add(flightObj.Diverted); 
       dateList.add(flightObj.FlightDate);
    } 
   
  }
  
  public void draw(){
    ellipseMode(CENTER);
    textFont(font);
    background(209, 207, 205);
    //numberOfFlights = this.numberOfFlights-1; // minus first line 
    if(doOnce){
        doOnce = false;
        font = loadFont("Menlo-Regular-15.vlw");
        textSize(15);
        pieCharts.getData(flightData);
        Integer[] cancelledArray = new Integer[cancelledList.size()];
        cancelledArray = cancelledList.toArray(cancelledArray);
        numberCancelled = howManyCancelledOrDiverted(cancelledArray);
        Integer[] divertedArray = new Integer[divertedList.size()];
        divertedArray = divertedList.toArray(divertedArray);
        numberDiverted = howManyCancelledOrDiverted(divertedArray);
        String[] datesArray = new String[dateList.size()];
        datesArray = dateList.toArray(datesArray);
        countOfEachDay = getDays(datesArray);

    }
    
    color textColor= color(143, 9, 64);
    pieChart(numberCancelled, 50, 60, "Cancelled", 20, 50, textColor, width/4, height/3, null);    
    textColor= color(3, 91, 173);
    pieChart(numberDiverted, (width-width/2.5), 60, "Diverted", 100, 200, textColor, width-200, height/3, null);
    textColor= color(0);
    pieChart(0, width/3+50, height/2, "on each day", 20, 10, textColor, width/2, height-180, countOfEachDay);
  }
  
  // returns the number of cancelled or diverted flights (depending which is passed in)
  int howManyCancelledOrDiverted(Integer[] list){
      int count=0;
      for (int i: list){
        if (i==1)       // if cancelled or diverted (=1)
          count++;
      }  
      return count;  
    }
  
  void pieChart(int count, float textX, float textY, String type, int color1, int color2, color textColor, float circleX, float circleY, int[]days){
    // uhttps://processing.org/examples/piechart.html
    float diameter = 300;
    float lastAngle = 0;
    float[]anglesList=new float[2];
    double proportion=0;
    float sum = 0;
    if (type =="Diverted"|| type=="Cancelled") {
      proportion = count/(double)numberOfFlights;
      int angle = (int)(proportion*360);
      anglesList[0] = angle;
      anglesList[1] = 360-angle;
    } else {
      anglesList= new float[days.length];
      for (int i=0;i<days.length;i++){
        float angle=(float)(days[i]/(double)numberOfFlights)*360;   
        anglesList[i] = angle; 
        sum+=angle;
      }
      if (sum<360){
        anglesList[0]+=360-sum;
      }
    }
    
    for (int i = 0; i < anglesList.length; i++) {
      float grayscale = map(i, 0, anglesList.length, 0, 255);
      fill(grayscale, color1, color2);
      arc(circleX, circleY, diameter, diameter, lastAngle, lastAngle+radians(anglesList[i]));
      lastAngle += radians(anglesList[i]);
    }
    fill(textColor); 
    double percentage = proportion*100;
    if (type =="Diverted"|| type=="Cancelled"){
      text("Number of Flights " + type + ": " + count + " (" + Math.round(percentage * 100.0)/100.0 + "%)", textX, textY);
    } else if (numberOfFlights <=100000){
       text("Distribution over the 6 days", textX, textY);
    } else {
      text("Distribution over the 31 days", textX, textY);
    }
  }
  
  int[] getDays(String[] flightDates){
    HashMap<Integer, Integer> daysAndFreq = new HashMap<>();
    // start at i=1 to skip first line (FL_DATE)
    for (int i=1; i<flightDates.length; i++) {
      
      String[] parts = flightDates[i].split("/");
      int day = Integer.valueOf(parts[1]);
      
      if (daysAndFreq.containsKey(day)) {
        daysAndFreq.put(day, daysAndFreq.get(day)+1);
      } else{
        daysAndFreq.put(day, 0);
      }
      
      
  
    /*
     //print hash map
    for(HashMap.Entry<Integer, Integer> entry : daysAndFreq.entrySet() ){
      System.out.println( entry.getKey() + " : " + entry.getValue() ); */
    }
   
    int[] daysArray = new int[daysAndFreq.size()];
    for (int freq=0; freq< daysArray.length; freq++){      
      daysArray[freq]= daysAndFreq.get(freq+1); 
    }
    
    
    return daysArray;
  }
  
  
}
