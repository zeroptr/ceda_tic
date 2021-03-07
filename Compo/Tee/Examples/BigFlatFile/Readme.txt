 TeeChart Pro 8
 Using TeeChart with virtual on-demand data.
 ---------------------------------------------

 To chart a very large quantity of data, the option
 of loading all points in memory can be impossible or
 very slow.

 The best (and with more sense) solution is to plot 
 a small quantity of the total number of points.

 This small "windows" of points is automatically handled
 by a small TDataSubSet class.


 This demo shows how to use the TDataSubSet class and the
 TAxisScrollbar control.

 In this example, a DataSubset is used to navigate a flat file
 composed of records with a "double" value.

 The flat file is very big (one million records), and the demo
 shows dinamically loading 100 points at a time when scrolling the
 chart.

 The AxisScrollbar control is displayed at the bottom, allowing
 full scroll of the full flat file.

 When running the demo for the first time, it will show a dialog
 to create the sample test file.

.....................................................................
