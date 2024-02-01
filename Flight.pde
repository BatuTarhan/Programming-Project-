class Flight {

  String FlightDate; //– The date of the flight in yyyymmdd format – you may ignore the hours and minutes (which are zero).
  String IATA_Code_Marketing_Airline; //– Code to identify the carrier e.g. AA.
  int Flight_Number_Marketing_Airline; //– The flight number (combine with the carrier code to obtain the usual format).
  String Origin; //- Origin Airport (text string).
  String OriginCityName; //- Origin Airport, City Name (text string).
  String OriginState; //– Origin Airport, State Code (text string).
  String OriginWac; //– Origin Airport, World Area Code (integer, see separate lookup table to map numbers to countries).
  String Dest; //- Destination Airport (text string)
  String DestCityName; //- Destination Airport, City Name (text string).
  String DestState; //- Destination Airport, State Code (text string).
  int DestWac; //- Destination Airport, World Area Code (integer, see separate lookup table to map numbers to countries).
  int CRSDepTime; //– Scheduled departure time (hhmm)
  int DepTime; //– Actual departure time (hhmm)
  int CRSArrTime; //– Scheduled arrival time.
  int ArrTime; //– Actual arrival time.
  int Cancelled; //– Cancelled Flight indicator (1=yes).
  int Diverted; //– Diverted Flight indicator (1=yes).
  double Distance; //– Distance between airports in miles.

  Flight(String line) {

    String[] data = split(line, ',');
    
    if (data.length==20) { // after first line there are twenty comma separated values
      this.FlightDate = data[0];
      this.IATA_Code_Marketing_Airline = data[1];
      this.Flight_Number_Marketing_Airline = int(data[2]);
      this.Origin = data[3];
      this.OriginCityName = data[4] + data[5]; // e.g. "New York, NY" is meant to be one value but there is a comma so add
      this.OriginState = data[6];
      this.OriginWac = data[7];
      this.Dest = data[8];
      this.DestCityName = data[9]+ data[10];
      this.DestState = data[11];
      this.DestWac = int(data[12]);
      this.CRSDepTime = int(data[13]);
      this.DepTime = int(data[14]);
      this.CRSArrTime = int(data[15]);
      this.ArrTime = int(data[16]);
      this.Cancelled = int(data[17]);
      this.Diverted = int(data[18]);
      this.Distance = int(data[19]);
    }
  }
}
