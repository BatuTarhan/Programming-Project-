/**
 * Class for implementing the US heat map of flights
 *
 * @author  Kitty Joyce
 */

import java.util.HashSet; 
import java.util.Collections;
import java.util.Arrays;


class HeatMap extends Widget {

  HashSet<String> uniqueOrigin = new HashSet<>();
  HashMap<String, Integer> frequencyMapOrigin = new HashMap<>();
  int frequencyOrigin[]; // make ArrayList

  HashSet<String> uniqueDest = new HashSet<>();
  HashMap<String, Integer> frequencyMapDest = new HashMap<>();
  int frequencyDest[]; // make ArrayList

  ArrayList<String> uniqueOriginList;
  ArrayList<String> uniqueDestList;
  
  ArrayList<String> topOriginAirports;
  ArrayList<String> topDestAirports;

  HashMap<String, Integer> allFlightsWithFrequency = new HashMap<>();
  int[][] heatMapData;
  
  boolean doOnce = true;
  boolean match = false;
  PFont size5font = loadFont("ArialHebrew-Bold-5.vlw");
  PFont size8font = loadFont("ArialHebrew-Bold-8.vlw");
  PFont size15font = loadFont("ArialHebrew-Bold-15.vlw");
  PFont menlo = loadFont("Menlo-Regular-15.vlw");
  
  HeatMap()
  {
    super();
  }

  void draw(){
    if (doOnce){
        doOnce=false;
        ArrayList<Flight> flightDataCopy = new ArrayList<>(flightData);   
        flightDataCopy.remove(0); // to remove labels in first line
           
        // only most common map
        calculateOrigin(flightDataCopy);
        calculateDest(flightDataCopy);
        calculateFrequencyTopAirports(flightDataCopy);
        storeData();
    }  
    drawCells(heatMapData, "topAirports");  
  }
  

  public void calculateOrigin(ArrayList <Flight> flightData) {
    for (Flight f : flightData) {
        uniqueOrigin.add(f.Origin);     
    } 
   
    uniqueOriginList = new ArrayList<>(uniqueOrigin);
    Collections.sort(uniqueOriginList); 

    for (int i = 0; i < uniqueOriginList.size(); i++) {
      frequencyMapOrigin.put(uniqueOriginList.get(i), 0);
    } 
    
    for (Flight f : flightData) { 
      String origin = f.Origin;
      int currentFrequency = frequencyMapOrigin.get(origin); 
      frequencyMapOrigin.put(origin, currentFrequency + 1); 
    } // for3

    frequencyOrigin = new int[uniqueOriginList.size()];
    for (int i = 0; i < uniqueOriginList.size(); i++) {
      String originAirport = uniqueOriginList.get(i); 
      frequencyOrigin[i] = frequencyMapOrigin.get(originAirport);
    } // for4
    
    // find the top 25 frequencies 
    ArrayList<Integer> topFrequencies = new ArrayList<>();  
    topOriginAirports = new ArrayList<>();  
    Arrays.sort(frequencyOrigin);
         
    for (int index = frequencyOrigin.length - 25; index < frequencyOrigin.length; index++) {
       topFrequencies.add(frequencyOrigin[index]);
    }
    
    boolean cont = true;
    for (HashMap.Entry<String, Integer> entry : frequencyMapOrigin.entrySet()) {
      cont=true;
      for (int frequency:topFrequencies){
        if (entry.getValue()== frequency && cont) {
          System.out.println(entry.getKey() + ": " + entry.getValue());
          topOriginAirports.add(entry.getKey());
          cont=false;
        }
      }     
    }
  } 
   
  // destination airports
  public void calculateDest(ArrayList<Flight> flightData) {

    for (Flight f : flightData) {
      uniqueDest.add(f.Dest);
    } // for1

    uniqueDestList = new ArrayList<>(uniqueDest);
    Collections.sort(uniqueDestList);

    for (int i = 0; i < uniqueDestList.size(); i++) {
      frequencyMapDest.put(uniqueDestList.get(i), 0);
    } // for2

    for (Flight f : flightData) {
      String dest = f.Dest;
      int currentFrequency = frequencyMapDest.get(dest);
      frequencyMapDest.put(dest, currentFrequency + 1);
    } // for3

    frequencyDest = new int[uniqueDestList.size()];
    for (int i = 0; i < uniqueDestList.size(); i++) {
      String dest = uniqueDestList.get(i);
      frequencyDest[i] = frequencyMapDest.get(dest);
    } // for4
    
    // find the top 25 frequencies of destination airports
    ArrayList<Integer> topFrequencies = new ArrayList<>();  
    topDestAirports = new ArrayList<>();  
    Arrays.sort(frequencyDest);
         
    for (int index = frequencyDest.length - 25; index < frequencyDest.length; index++) {
       topFrequencies.add(frequencyDest[index]);
    }
    
    boolean cont = true;
    for (HashMap.Entry<String, Integer> entry : frequencyMapDest.entrySet()) {
      cont=true;
      for (int frequency:topFrequencies){
        if (entry.getValue()== frequency && cont) {
          System.out.println(entry.getKey() + ": " + entry.getValue());
          topDestAirports.add(entry.getKey());
          cont=false;
        }
      }     
    }
  } 

  
  public void calculateFrequencyTopAirports(ArrayList<Flight> flightData) {
    // Create a new HashMap to store the top origin-destinations with their frequency
    // (origin-destination, frequency)

    // Iterate through each flight in the flightData list
    for (Flight flight : flightData) {
      // Check if the flight's origin and destination are in the top origins and top destinations lists
      if (topOriginAirports.contains(flight.Origin) && topDestAirports.contains(flight.Dest)) {
        String key = flight.Origin + "-" + flight.Dest;
        if (!allFlightsWithFrequency.containsKey(key)) {  
          allFlightsWithFrequency.put(key, 0);           
        }
        allFlightsWithFrequency.put(key, allFlightsWithFrequency.get(key) + 1); 
      }
    }
    for (HashMap.Entry<String, Integer> entry : allFlightsWithFrequency.entrySet()) {
      System.out.println(entry.getKey() + ": " + entry.getValue());
    }
  }

  
  
  public void storeData() {
    heatMapData = new int[topOriginAirports.size()][topDestAirports.size()];  // your heat map data
    
    // iterate through the possible origin-destinations and add frequencies to 2d array
    int uOLindex = 0;
    for (int row = 0; (row < heatMapData.length); row++){     
      String originAirport = topOriginAirports.get(uOLindex);
      int uDLindex =0;     
      for (int column = 0; (column < heatMapData[row].length); column++){     
        String destinationAirport = topDestAirports.get(uDLindex);     
        String possiblyAKey = originAirport + "-" + destinationAirport;     
        match=false;
        for (String flightKey : allFlightsWithFrequency.keySet()){
          if (possiblyAKey.equals(flightKey)){
            heatMapData[row][column] = allFlightsWithFrequency.get(flightKey);
            match=true;
          }
        }
        if (!match) { // if there are no flights with this origin-destination 
          heatMapData[row][column] = 0;
        }    
        uDLindex++;
      }
      uOLindex++;
    }
    
  }

  public void drawCells(int[][] heatMapData, String type) {
    fill(255);
    background(0);
    int border, leftMargin=13;
    int numRows, numCols;
    float rectWidth, rectHeight;
    
    
   
      numRows = topOriginAirports.size(); 
      numCols = topDestAirports.size();
      border = 55;
      rectWidth = (width-(border*2)+leftMargin)/ (float)numCols;
      rectHeight = (height-(border*2))/ (float)numRows;

     
      // display destination airport names above boxes on x axis
      int xposition=border+ leftMargin +12; 
      for (String airport : topDestAirports) {
        textFont(size8font);
        textSize(8);
        text(airport, xposition, border-5);
        xposition+=rectWidth;
      }
      
      // display origin airport names on y axis
      int yposition = border+ 14;
      for (String airport : topOriginAirports) {
        textFont(size8font);
        textSize(8);
        text(airport, border-10, yposition);
        yposition+=rectHeight+0.39;
        if (airport.equals("PHX") || airport.equals("MCO")|| airport.equals("ANC")){
          yposition+=5;
        } 
      }
      // display headings
      textFont(menlo);
      textSize(15);
      text("25 Most Popular Destination Airports", width/3, 23);
      
      float xpos = 32;
      float ypos = height/2;
      textAlign(CENTER, BOTTOM);    
      pushMatrix();
      translate(xpos,ypos);
      rotate(-HALF_PI);
      text("25 Most Popular Origin Airports",0,0);
      popMatrix();
    

    int maxValue = heatMapData[0][0];
    for (int i = 0; i < heatMapData.length; i++) {
      for (int j = 0; j < heatMapData[0].length; j++) {   // less than number of cols
        if (heatMapData[i][j] > maxValue) {
          maxValue = heatMapData[i][j];
       
        }
      }
    }
    String airportsWithMaxValue = "";
    for (HashMap.Entry<String, Integer> entry : allFlightsWithFrequency.entrySet()) {
      if (entry.getValue().equals(maxValue)) {
        airportsWithMaxValue= entry.getKey();
      }      
    }
   
    
    text("Highest flight frequency: " + maxValue + " with the origin-destination " + airportsWithMaxValue, width/2, height-20);
    
    
    // Make grid 
    int row=0;
    //int rectCount=0;
    for (float y = border; y < height-border; y = y + rectHeight) {     
      if (row < numRows) {
        int column =0;
        for (float x = border+leftMargin; x < width-border; x = x + rectWidth) { 
          if (column<numCols) {
              int freq = heatMapData[row][column];
              
              // colours (red/warmer for higher numbers, green/colder for lower numbers)
              if (freq==0) {
                fill(36, 143, 54); // green    
              } 
              else if (freq <maxValue/5) {
                fill(60, 186, 81); // light green 
              } 
              else if (freq < maxValue/4) {
                fill(250, 197, 5); // yellow 
              } 
              else if (freq<maxValue/3 ) {
                fill(252, 157, 3); // orange
              }
              else if (freq < maxValue/2) {
                fill(245, 128, 32); //  orange           
              }
              else if (freq < maxValue/1.5) {
                fill(245, 94, 29); // light red           
              }
              else {
                fill (227, 37, 34); // red
              }   
              stroke(0);
              rect(x, y, rectWidth, rectHeight);
              //rectCount++;
              fill(255);
              textAlign(CENTER, CENTER);
              textFont(size15font);
              textSize(15);
              text(freq, x + rectWidth/2, y+ rectHeight/2);
              column++;
          }
        }
    }
    row++;
  }
  
  }
} 
