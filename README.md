# FlightData GROUP 47 - CSU11013 Programming Project 2023

## Table Of Contents

1. [Group Members](#group-members)
2. [Using the SQLWrapper class](#using-the-sqlwrapper-class)
3. [Using the Widget Class](#using-the-widget-class)
4. [Using the Screen Class](#using-the-screen-class)

## **Group Members**

| Name                        | Username    |
| --------------------------- | ----------- |
| Batu Tarhan                 | tarhanBatu  |
| Hanna Gorynska              | Hannaxgy    |
| Kitty Joyce                 | kittyajoyce |
| Justin Ikechukwu Cunningham | JustCunn    |

## **Using the SQLWrapper Class**

### **You first must include BezierSQLib in Proceesing**

To do this, in the top bar of any Processing file, go to `sketch` > `Import Library...` > `Manage Libraries` > search for `BezierSQLib` > click Install

## SQLWrapper Object

The `SQLWrapper` class queries the remote database for data.

To create an instance of the class, use

```java
sql = new SQLWrapper(database, table);
```

`database` is a `MySQL` object

`table` is a string - it's the name of the table you wish to query.

## getWithFilter (returns `ArrayList<DataPoint>`)

`getWithFilter` is a method that gets instances in the database where they all match with in one column

For example,

```java
ArrayList<DataPoint> list = sql.getWithFilter("originState", "NY");
```

returns **all** the rows where the flight originated in New York.

You can also use it to get a certain number of entries from a certain starting point,

```java
ArrayList<DataPoint> list = sql.getWithFilter("originState", "NY", 9, 5);
```

will return the 10th flight from New York to the 15th flight.

## getSorted (returns `ArrayList<DataPoint>`)

`getSorted` is a method that gets instances in the database, sorted by one column.

For example,

```java
ArrayList<DataPoint> list = sql.getSorted("date", false);
```

will return **all** the flights starting with the _oldest_ flight.

Whereas,

```java
ArrayList<DataPoint> list = sql.getSorted("date", true);
```

will return **all** the flights starting with the _newest_ flight.

## getUnordered (returns `ArrayList<DataPoint>`)

`getUnordered` is a method that returns all rows in their unordered state (i.e. how they are ordered in the dataset).

```java
ArrayList<DataPoint> list = sql.getUnordered();
```

You can also use it to get a certain section of rows,

```java
ArrayList<DataPoint> list = sql.getUnordered(34, 10);
```

will return the 35th row to the 45th.

## countWithFilter (returns `int`)

`countWithFilter` returns the number of flights that fulfill a certain criteria.

For example,

```java
int count = sql.countWithFilter("originState", "WY");
```

will return the number of flights that originated in Wyoming.

## getByLateness (returns `ArrayList<DataPoint>`)

`getByLateness` returns the dataset in order of lateness.

```java
ArrayList<DataPoint> list = sql.getByLateness(false);
```

will return the rows with the latest flight first.

```java
ArrayList<DataPoint> list = sql.getByLateness(false);
```

will return the rows with the latest flight last.

## **Using the Widget Class**

The Widget class is a skeleton class that helps implement widgets.

To create a new widget class by 'extending' the Widget class, use:

```java
public class <ClassName> extends Widget
{
  <ClassName>(int x, int y, int width, int height, int event)
  {
    super(x, y, width, height, event);
    // Other constructor code
  }
}
```

You can get the following properties in your widget

- x coordinate - use `this.x()`,
- y coordinate - use `this.y()`,
- width - use `this.width()`,
- height - use `this.height()`,
- Whether the mouse is hovering over the widget (returns `boolean`) - use `this.hovered()`

## **Using the Screen Class**

The Screen class is a skeleton class that helps implement screens.

To create a screen, instantiate a screen object in main

```java
Screen screen1;

void setup()
{
  // the only constructor arg is 'background color'
  screen1 = new Screen(color(255));
}
```

Then add any widget that you have created using `addWidget`, e.g.

```java
Screen screen1;
Dropdown dropdown;

void setup()
{
  // the only constructor arg is 'background color'
  screen1 = new Screen(color(255));
  dropdown = new Dropdown(100, 133, 190, 50, EVENT_BUTTON4);
  screen1.addWidget(dropdown);
}
```

Finally, in draw, call `draw()`,

```java
void draw()
{
  screen1.draw()
}
```
