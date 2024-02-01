/**
 * Class for implementing radial charts (like Apple Watch rings).
 *
 * @author  Batu Tarhan
 */

import java.util.Collection;

class RadialBarChart {

  ArrayList<String> delay = new ArrayList();
  ArrayList<Integer> canceledIndex = new ArrayList();

  HashMap<String, ArrayList<Integer>> iataIndicesMap;
  HashMap<String, Integer> iataTotalDelayMap;
  HashMap<String, Integer> iataCountMap;
  HashMap<String, Float> iataWithAvrg;

  color[] colors;

    public void fillColors() {
    colors = new color[iataWithAvrg.keySet().size()+1];
    
    colors[0] = color(255, 0, 0); // red
    colors[1] = color(0, 255, 0); // green
    colors[2] = color(0, 0, 255); // blue
    colors[3] = color(255, 255, 0); // yellow
    colors[4] = color(255, 0, 255); // magenta
    colors[5] = color(0, 255, 255); // cyan
    colors[6] = color(255, 165, 0); // orange
    colors[7] = color(128, 0, 128); // purple
    colors[8] = color(255, 99, 71); // tomato
    colors[9] = color(0, 191, 255); // deep sky blue
    colors[10] = color(255, 192, 203); // pink
  }

  public void calculateDelay(ArrayList<Flight> flightData) {

    for (Flight f : flightData) {
      int late = f.ArrTime - f.CRSArrTime;

      if (f.Cancelled == 1)
        delay.add("X");
      else
        delay.add(String.valueOf(late));
    }
  }


  public void calculateAvrg(ArrayList<Flight> flightData) {
    // Create a map to store the indices of each unique IATA code
    iataIndicesMap = new HashMap<>();

    // Iterate through each flight in the list and calculate the total delay for each IATA code
    iataTotalDelayMap = new HashMap<>();
    iataCountMap = new HashMap<>();
    iataWithAvrg = new HashMap<>();

    for (int i = 0; i < flightData.size(); i++) {
      Flight flight = flightData.get(i);
      String iataCode = flight.IATA_Code_Marketing_Airline;

      // If this is the first time seeing this IATA code, add it to the index map with an empty list
      if (!iataIndicesMap.containsKey(iataCode)) {
        iataIndicesMap.put(iataCode, new ArrayList<>());
      }

      // Add the current index to the list of indices for this IATA code
      iataIndicesMap.get(iataCode).add(i);

      // If this flight was not cancelled, add its delay to the total delay for this IATA code
      if (flight.Cancelled == 0) {
        int delay = flight.ArrTime - flight.CRSArrTime;
        if (!iataTotalDelayMap.containsKey(iataCode)) {
          iataTotalDelayMap.put(iataCode, delay);
          iataCountMap.put(iataCode, 1);
        } else {
          iataTotalDelayMap.put(iataCode, iataTotalDelayMap.get(iataCode) + delay);
          iataCountMap.put(iataCode, iataCountMap.get(iataCode) + 1);
        }
      }
    }

    // Create a map to store the average delay for each IATA code

    for (String iataCode : iataTotalDelayMap.keySet()) {
      float avgDelay = (float) iataTotalDelayMap.get(iataCode) / iataCountMap.get(iataCode);
      iataWithAvrg.put(iataCode, avgDelay);
    }

    // Print out the indices and average delay for each unique IATA code
  } // methos

  void draw() {
    Collection<Float> iataValues = iataWithAvrg.values();

    // find the minimum and maximum delay values
    Float minValue = Collections.min(iataValues);
    Float maxValue = Collections.max(iataValues);

    float radius = 100;
    float centerX = width / 2;
    float centerY = height / 2;

    int i = 0;
    float startAngle = -PI/2; // Set the starting angle to -90 degrees or 3*PI/2
    float endAngle = 0;
    for (Float avrg : iataValues) {
      noFill();
      strokeWeight(8);
      stroke(colors[i]);
      endAngle = map(avrg, minValue, maxValue, 0, 2*PI);
      arc(centerX, centerY, radius + i*30, radius + i*30, startAngle, startAngle + endAngle);
      startAngle += endAngle; // Update startAngle based on the current endAngle
      i++;
    }
    int y = 100;
    int q = 0;
    for (String iataCode : iataIndicesMap.keySet()) {
      strokeWeight(0);
      float avgDelay = iataWithAvrg.get(iataCode);
      fill(colors[q]);
      rect(70,y-12,20,10);
      fill(0);
      text(iataCode+" -> ("+avgDelay+")", 100, y);
      y += 15;
      q++;
      //System.out.println(iataCode + ":  - Average delay: " + avgDelay);
    }
  }
} // class
