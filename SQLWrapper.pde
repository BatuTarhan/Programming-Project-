/**
 * A wrapper class that abstracts the core SQL commands needed
 * in this project.
 *
 * @author  Justin Ikechukwu Cunningham
 */

public class SQLWrapper
{
  private MySQL db;
  private String tableName;
  
  SQLWrapper(MySQL db, String tableName)
  {
    this.db = db;
    this.tableName = tableName;
  }
  
  /**
  * Returns a DataPoint ArrayList based on the results of the current 
  * unattended query of the db instance variable
  *
  * @return              DataPoint ArrayList
  * @return              DataPoint ArrayList
  */
  private ArrayList<DataPoint> createDataPointArr()
  {
    ArrayList<DataPoint> arr = new ArrayList();
    while (this.db.next())
    {
      arr.add(new DataPoint(this.db));
    }
    return arr;
  }
  
  /**
  * Returns the full unordered table from a MySQL database
  * 
  * @return              DataPoint ArrayList with results
  */
  public ArrayList<DataPoint> getUnordered()
  {
    this.db.query("SELECT * FROM " + this.tableName + ";");
    return this.createDataPointArr();
  }
  
  /**
  * Returns a selection of unordered data in a table from a MySQL database
  *
  * @param  start        the row to start getting data from
  * @param  end          the amount of rows to return
  * @return              DataPoint ArrayList with results
  *
  */
  public ArrayList<DataPoint> getUnordered(int start, int end)
  {
    if (start < 0) return new ArrayList<DataPoint>();
    this.db.query("SELECT * FROM " + this.tableName + " LIMIT " + start + ", " + end + ";");
    return this.createDataPointArr();
  }
  
  /**
  * Returns all rows under a single condition
  *
  * @param  filter       the name of the column to filter by
  * @param  query        the query used to filter by a column
  * @return              DataPoint ArrayList with results
  *
  */
  public ArrayList<DataPoint> getWithFilter(String filter, String query)
  {
    this.db.query("SELECT * FROM " + this.tableName + " WHERE " + filter + "='" + query + "';");
    return this.createDataPointArr();
  }
  
  /**
  * Returns a selection of rows under a single condition
  *
  * @param  filter       the name of the column to filter by
  * @param  query        the query used to filter by a column
  * @param  start        the row to start getting data from
  * @param  end          the amount of rows to return
  * @return              DataPoint ArrayList with results
  *
  */
  public ArrayList<DataPoint> getWithFilter(String filter, String query, int start, int end)
  {
    this.db.query("SELECT * FROM " + tableName + " WHERE " + filter + "='" + query + "' LIMIT " + start + ", " + end + ";");
    return this.createDataPointArr();
  }
  
  public ArrayList<DataPoint> getWithFilter(String filter, String query, int start, int end, int dateStart, int dateEnd)
  {
    this.db.query("SELECT * FROM " + tableName + " WHERE " + filter + "='" + query + "' AND date > '2022-01-"+
    (dateStart<10 ? "0" : "") + dateStart + "' AND date < '2022-01-"+ (dateEnd<10 ? "0" : "") + dateEnd + "' LIMIT " + start + ", " + end + ";");
    return this.createDataPointArr();
  }
  
  /**
  * Returns all rows under two conditions
  *
  * @param  filter1      the name of the first column to filter by
  * @param  query1       the query used with the first filter
  * @param  filter2      the name of the second column to filter by
  * @param  query2       the query used with the second filter
  * @return              DataPoint ArrayList with results
  *
  */
  public ArrayList<DataPoint> getWithTwoFilters(String filter1, String query1, String filter2, String query2)
  {
    this.db.query("SELECT * FROM " + this.tableName + " WHERE " + filter1 + "='" + query1 + "' AND " + filter2 + "='" + query2 + "';");
    return this.createDataPointArr();
  }
  
  /**
  * Returns a selection of rows rows under two conditions
  *
  * @param  filter1      the name of the first column to filter by
  * @param  query1       the query used with the first filter
  * @param  filter2      the name of the second column to filter by
  * @param  query2       the query used with the second filter
  * @param  start        the row to start getting data from
  * @param  rows         the amount of rows to return
  * @return              DataPoint ArrayList with results
  *
  */
  public ArrayList<DataPoint> getWithTwoFilters(String filter1, String query1, String filter2, String query2, int start, int rows)
  {
    this.db.query("SELECT * FROM " + this.tableName + " WHERE " + filter1 + "='" + query1 + "' AND " + filter2 + "='" + query2 + 
                  "' LIMIT " + start + ", " + rows + ";");
    return this.createDataPointArr();
  }
  
  /**
  * Returns a selection of rows under a single condition in a certain order
  * <p>
  * If the order relates to actual times, only flights that were not cancelled or diverted
  * are considered
  *
  * @param  filter       the name of the column to filter by
  * @param  query        the query used to filter by a column
  * @param  start        the row to start getting data from
  * @param  end          the amount of rows to return
  * @param  order        the order to sort the rows
  * @return              DataPoint ArrayList with results
  *
  */
  public ArrayList<DataPoint> getWithFilter(String filter, String query, int start, int end, String order)
  {
    boolean noCancelDiverts = false;
    if (order == "actualDep" || order == "actualDep DESC" || order == "actualArr" || order == "actualArr DESC")
      noCancelDiverts = true;
    this.db.query("SELECT * FROM " + tableName + " WHERE " + filter + "='" + query + (noCancelDiverts ? "' AND cancelled=0 AND diverted=0" : "'") +
                  " ORDER BY " + order + " LIMIT " + start + ", " + end + ";");
    return this.createDataPointArr();
  }
  
  public ArrayList<DataPoint> getWithFilter(String filter, String query, int start, int end, String order, int dateStart, int dateEnd)
  {
    boolean noCancelDiverts = false;
    if (order == "actualDep" || order == "actualDep DESC" || order == "actualArr" || order == "actualArr DESC")
      noCancelDiverts = true;
    this.db.query("SELECT * FROM " + tableName + " WHERE " + filter + "='" + query + (noCancelDiverts ? "' AND cancelled=0 AND diverted=0" : "'") 
                  + " AND date > '2022-01-"+ (dateStart<10 ? "0" : "") + dateStart + "' AND date < '2022-01-"+ (dateEnd<10 ? "0" : "") + dateEnd +
                  "' ORDER BY " + order + " LIMIT " + start + ", " + end + ";");
    return this.createDataPointArr();
  }
  
  /**
  * Returns all rows in a certain order
  *
  * @param  filter       the name of the column to filter by
  * @param  order        the order to sort the rows
  * @return              DataPoint ArrayList with results
  *
  */
  public ArrayList<DataPoint> getSorted(String filter, boolean descending)
  {
    String order = descending ? "DESC" : "ASC";
    this.db.query("SELECT * FROM " + tableName + " ORDER BY " + filter + " " + order + ";");
    return this.createDataPointArr();
  }
  
  /**
  * Returns the number of rows that fit a single condition
  *
  * @param  filter       the name of the column to filter by
  * @param  query        the query used to filter by a column
  * @return              the number of rows that fit the condition
  *
  */
  public int countWithFilter(String filter, String query)
  {
    this.db.query("SELECT COUNT(origin) FROM " + this.tableName + " WHERE " + filter + "='" + query + "';");
    if (this.db.next())
    {
      return db.getInt(1);
    }
    return 0;
  }
  
  /**
  * Returns the number of rows that fit two conditions
  *
  * @param  filter1      the name of the first column to filter by
  * @param  query1       the query used with the first filter
  * @param  filter2      the name of the second column to filter by
  * @param  query2       the query used with the second filter
  * @return              the number of rows that fit the conditions
  *
  */
  public int countWithFilter(String filter1, String query1, String filter2, String query2)
  {
    this.db.query("SELECT COUNT(*) FROM " + this.tableName + " WHERE " + filter1 + "='" + query1 + "' AND " + filter2 + "='" + query2 + "';");
    if (this.db.next())
    {
      println("next");
      return db.getInt(1);
    }
    //println(tmp.size());
    return 0;
  }
  
  /**
  * Returns the distance between any two airports
  * <p>
  * It returns the first such distance between the two airports
  *
  * @param  origin       the IATA code of the origin airport
  * @param  dest         the IATA code of the destination airport
  * @return              the distance between the airports
  *
  */
  public int getDistance(String origin, String dest)
  {
    this.db.query("SELECT * FROM " + this.tableName + " WHERE origin='" + origin + "' AND dest='" + dest + "' LIMIT 1;");
    db.next();
    return db.getInt("distance");
  }
  
  public ArrayList<DataPoint> getByLatenessWithFilter(boolean latestLast, String filter, String query, int start, int end)
  {
    String isLatestLast = latestLast ? "ASC" : "DESC";
    this.db.query("SELECT *, @aT := CAST(CONCAT(SUBSTRING(LPAD(actualArr, 4, 0),1,2), ':', SUBSTRING(LPAD(actualArr, 4, 0),3,4)) AS TIME(0))," + 
                  "@sT := CAST(CONCAT(SUBSTRING(LPAD(scheduleArr, 4, 0),1,2), ':', SUBSTRING(LPAD(scheduleArr, 4, 0),3,4)) AS TIME(0))," +
                  "@diff := (HOUR(TIMEDIFF(@aT, @sT))*60 + MINUTE(TIMEDIFF(@aT, @sT)) + 1440) % 1440," +
                  "CASE WHEN @diff > 90 AND scheduleArr > actualArr THEN scheduleArr - actualArr + 2400 - 40 * (HOUR(@aT)+1) "+
                  "WHEN scheduleArr > actualArr THEN -(@diff) % 1440 " +
                  "ELSE @diff END as timeDiff FROM " + this.tableName + " WHERE cancelled=0 AND diverted=0 AND " + filter + "='" + query +
                  "' ORDER BY timeDiff " + isLatestLast + " LIMIT " + start + ", " + end + ";");
    return this.createDataPointArr();
  }
  
  public ArrayList<DataPoint> getByLateness(boolean latestLast)
  {
    String isLatestLast = latestLast ? "ASC" : "DESC";
    this.db.query("SELECT @aT := CAST(CONCAT(SUBSTRING(LPAD(actualArr, 4, 0),1,2), ':', SUBSTRING(LPAD(actualArr, 4, 0),3,4)) AS TIME(0))," + 
                  "@sT := CAST(CONCAT(SUBSTRING(LPAD(scheduleArr, 4, 0),1,2), ':', SUBSTRING(LPAD(scheduleArr, 4, 0),3,4)) AS TIME(0))," +
                  "@diff := (HOUR(TIMEDIFF(@aT, @sT))*60 + MINUTE(TIMEDIFF(@aT, @sT)) + 1440) % 1440," +
                  "CASE WHEN @diff > 90 AND scheduleArr > actualArr THEN scheduleArr - actualArr + 2400 - 40 * (HOUR(@aT)+1) "+
                  "WHEN scheduleArr > actualArr THEN -(@diff) % 1440 " +
                  "ELSE @diff END as timeDiff FROM " + this.tableName + " WHERE cancelled=0 AND diverted=0 ORDER BY timeDiff " + isLatestLast + ";");
    return this.createDataPointArr();
  }
}
