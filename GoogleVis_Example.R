## Please note that by default the googleVis plot command
## will open a browser window and requires Flash and Internet
## connection to display the visualisation.
require(googleVis)

con <- dbConnect(drv, dbname="postgres", host ="localhost", port=5432, user="postgres", password="Exc!te")
rd <- dbGetQuery(con, "select * from Excite_ESA")
   
Pie1 <- gvisPieChart(Excite)
plot(Pie1)

## Doughnut chart - a pie with a hole
Pie2 <- gvisPieChart(CityPopularity, options=list(
  slices="{4: {offset: 0.2}, 0: {offset: 0.3}}",
  title='City popularity',
  legend='none',
  pieSliceText='label',
  pieHole=0.5))
plot(Pie2)









## timevar Year
M1 <- gvisMotionChart(rd, idvar="team_name", timevar="id")
str(M1)
## print.gvis, will concatenate the list into a one long string
M1

plot(M1)

## Combine with another chart, e.g. table
tbl <- gvisTable(Fruits, options=list(height=220))
Mtbl <- gvisMerge(M1, tbl)
plot(Mtbl)


## Not run:
## Usage of date variable
M2 <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Date",
                      date.format = "%Y%m%d") 
plot(M2)

## Display weekly data:
M3 <- gvisMotionChart(Fruits, "Fruit", "Date", date.format="%YW%W")

plot(M3) 
## End(Not run)

## Options: no side panel on the right
M4 <- gvisMotionChart(Fruits,"Fruit", "Year",
                      options=list(showSidePanel=FALSE))
plot(M4)

## Options: trails un-ticked
M5 <- gvisMotionChart(Fruits, "Fruit", "Year",
                      options=list(state='{"showTrails":false};'))

plot(M5)

## You can change some of displaying settings via the browser,
## e.g. the level of opacity of non-selected items, or the chart type.
## The state string from the 'Advanced' tab can be used to set those
## settings via R. Just copy and past the string from the browser into
## the argument state of the options list.
## Here is an example of a motion chart, with an initial line chart
## displayed. Ensure that you have a newline at the start and end of
## your settings string.

myStateSettings <-'
{"xZoomedDataMin":1199145600000,"colorOption":"2",
"duration":{"timeUnit":"Y","multiplier":1},"yLambda":1,
"yAxisOption":"4","sizeOption":"_UNISIZE",
"iconKeySettings":[],"xLambda":1,"nonSelectedAlpha":0,
"xZoomedDataMax":1262304000000,"iconType":"LINE",
"dimensions":{"iconDimensions":["dim0"]},
"showTrails":false,"uniColorForNonSelected":false,
"xAxisOption":"_TIME","orderedByX":false,"playDuration":15000,
"xZoomedIn":false,"time":"2010","yZoomedDataMin":0,
"yZoomedIn":false,"orderedByY":false,"yZoomedDataMax":100}
'
M6a <- gvisMotionChart(Fruits, "Fruit", "Year", options=list(state=myStateSettings))
plot(M6a)
 
## Newline set explicitly
myStateSettings <-'\n{"iconType":"LINE"}\n'
M6b <- gvisMotionChart(Fruits, "Fruit", "Year", options=list(state=myStateSettings))
plot(M6b)
 
 
## Define which columns are used for the initial setup of the various
## dimensions
M7 <- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year",
                              xvar="Profit", yvar="Expenses",
                              colorvar="Location", sizevar="Sales")
plot(M7)
 
## For more information see:
## <a href="https://developers.google.com/chart/interactive/docs/gallery/motionchart</p>
<p>##" title="https://developers.google.com/chart/interactive/docs/gallery/motionchart</p>
<p>##">https://developers.google.com/chart/interactive/docs/gallery/motionchart...</p></a> See also the demo(WorldBank). It demonstrates how you can access
## country level data from the World Bank to create Gapminder-like
## plots.