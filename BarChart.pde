/**
 * This class implements bar charting functionality
 *
 * @author  Batu Tarhan
 */

import java.util.HashSet;
import java.util.Collections;

class BarChart {

  float barWidth = 0;

  int barNum = 0;
  int frequency[];

  int startIndex;
  int endIndex;
  int startDate;
  int endDate;

  String userInput1 = "";
  String userInput2 = "";

  color textC = color(255);

  HashSet<String> uniqueIataCodes = new HashSet<String>();
  HashMap<String, Integer> frequencyMap = new HashMap<>();

  ArrayList<String> allDates = new ArrayList();


  public void calculate(ArrayList<Flight> flightData) {

    for (Flight f : flightData) {
      uniqueIataCodes.add(f.IATA_Code_Marketing_Airline);
    } // for1

    ArrayList<String> uniqueIataCodesList = new ArrayList<>(uniqueIataCodes);
    //Collections.sort(uniqueIataCodesList);

    for (int i = 0; i < uniqueIataCodesList.size(); i++) {
      frequencyMap.put(uniqueIataCodesList.get(i), 0);
    } // for2

    for (Flight f : flightData) {
      String iataCode = f.IATA_Code_Marketing_Airline;
      int currentFrequency = frequencyMap.get(iataCode);
      frequencyMap.put(iataCode, currentFrequency + 1);
    } // for3

    frequency = new int[uniqueIataCodesList.size()];

    for (int i = 0; i < uniqueIataCodesList.size(); i++) {
      String iataCode = uniqueIataCodesList.get(i);
      frequency[i] = frequencyMap.get(iataCode);
    } // for4
  }


  // method to draw the BarChart
  public void draw(int multiplier) {
    barNum = uniqueIataCodes.size();

    barWidth = width / barNum - 10;

    // Pre-calculate bar positions and sizes
    float barX[] = new float[barNum];
    float barY[] = new float[barNum];
    float barHeight[] = new float[barNum];

    for (int i = 0; i < frequency.length; i++) {
      frequency[i] = frequency[i] / multiplier;
    }

    for (int i = 0; i < barNum; i++) {
      barX[i] = i * barWidth + 100;
      barY[i] = height - frequency[i];
      barHeight[i] = frequency[i];
    }

    // Draw Bars and Labels
    textSize(16);
    textAlign(CENTER, TOP);

    int i = 0;
    textSize(16);
    textAlign(CENTER, TOP);
    for (String iataCode : uniqueIataCodes) {
      fill(255, 0, 0);
      stroke(0);
      rect(barX[i], barY[i], barWidth, barHeight[i]);
      fill(0);
      text(frequency[i]*multiplier, barX[i] + barWidth / 2, barY[i] - 18);
      textSize(18);
      text(iataCode, barX[i]+ barWidth / 2, height - 20);
      i++;
    }
    textSize(20);
    text("Total Flight Count Of Each Plane", 500, 40);
    textAlign(LEFT, BASELINE);
  }

  public void drawScale(int multiplier) {
    noStroke();
    fill(0);
    rect(10, 0, 3, height);
    textSize(15);
    for (int i = height; i >= 0; i--) {
      if (i % 100 == 0) {
        rect(5, i, 13, 3);
        fill(0, 0, 255);
        text(i*multiplier, 20, height-i + 15);
      }
      if (i == height) {
        fill(0);
        rect(5, i-5, 13, 3);
        fill(0, 0, 255);
        text("0", 20, height-15 + 15);
      }
    }
  }
} // class
