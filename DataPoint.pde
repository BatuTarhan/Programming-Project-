/**
 * Class for storing the data of individual rows from the database
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class DataPoint
{
  String date, carrier, origin, originCityName, originStateAbr, dest, destCityName, destStateAbr;
  int flightNum, originWac, destWac, scheduledDepTime, actualDepTime, scheduledArrTime, actualArrTime, distance;
  boolean cancelled, diverted;
  
  DataPoint(MySQL db)
  {
    this.date = db.getString("date");
    this.carrier = db.getString("carrier");
    this.flightNum = db.getInt("flightNum");
    this.origin = db.getString("origin");
    this.originCityName = db.getString("originCity").split(", ")[0];
    this.originStateAbr = db.getString("originState");
    this.dest = db.getString("dest");
    this.destCityName = db.getString("destCity").split(", ")[0];
    this.destStateAbr = db.getString("destState");
    this.originWac = db.getInt("originWac");
    this.destWac = db.getInt("destWac");
    this.scheduledDepTime = db.getInt("scheduleDep");
    this.actualDepTime = db.getInt("actualDep");
    this.scheduledArrTime = db.getInt("scheduleArr");
    this.actualArrTime = db.getInt("actualArr");
    this.cancelled = db.getBoolean("cancelled");
    this.diverted = db.getBoolean("diverted");
    this.distance = db.getInt("distance");
  };
  
  //public String getDate() return this.date;
  //public String getCarrier() return this.carrier;
  //public String getOrigin() return this.origin;
  //public String getOriginCityName() return this.originCityName;
  //public String getOriginStateAbr() return this.originStateAbr;
  //public String getDest() return this.dest;
  //public String getDestCityName() return this.destCityName;
  //public String getDestStateAbr() return this.destStateAbr;
  //public String getFlightNum() return this.flightNum;
  //public int getOriginWac() return this.originWac;
  //public int getDestWac() return this.destWac;
  //public int getScheduledDepTime() return this.scheduledDepTime;
  //public int getActualDepTime() return this.actualDepTime;
  //public int getScheduledArrTime() return this.scheduledArrTime;
  //public int getActualArrTime() return this.actualArrTime;
  //public int getCancelled() return this.cancelled;
  //public int getDiverted() return this.diverted;
  //public int getDistance() return this.distance;
}
