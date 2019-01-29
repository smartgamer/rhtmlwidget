# To embed R generated html to webpages 
library(tidyverse)

#leaflet ----
#https://www.htmlwidgets.org/showcase_leaflet.html
# install.packages("leaflet")
library(leaflet)
pal <- colorQuantile("YlOrRd", NULL, n = 8)
#data from: http://geog.uoregon.edu/bartlein/old_courses/geog414s05/topics/maps.htm
orstationc = read.csv("orstationc.csv")
leaflet(orstationc) %>% 
  addTiles() %>%
  addCircleMarkers(color = ~pal(tann))


#charting time-series data ----
# install.packages("dygraphs")
library(dygraphs)
dygraph(nhtemp, main = "New Haven Temperatures") %>% 
  dyRangeSelector(dateWindow = c("1920-01-01", "1960-01-01"))

# plotly D3 ----
#Plotly allows you to easily translate your ggplot2 graphics to an interactive web-based version, 
library(ggplot2)
library(plotly)
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")
ggplotly(p)
#also provides high-level bindings for working directly with plotly.js.
d <- diamonds[sample(nrow(diamonds), 500), ]
plot_ly(d, x = d$carat, y = d$price, 
        text = paste("Clarity: ", d$clarity),
        mode = "markers", color = d$carat, size = d$carat)

#bokeh:declarative framework for creating web-based plots. ----
install.packages("rbokeh")
library(rbokeh)
figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
            color = Species, glyph = Species,
            hover = list(Sepal.Length, Sepal.Width))

#Highcharts is free for non-commercial use but otherwise requires a license.----
library(magrittr)
library(highcharter)
highchart() %>% 
  hc_title(text = "Scatter chart with size and color") %>% 
  hc_add_series_scatter(mtcars$wt, mtcars$mpg,
                        mtcars$drat, mtcars$hp)


#visNetwork----
install.packages("visNetwork")
library(visNetwork)
nodes <- data.frame(id = 1:6, title = paste("node", 1:6), 
                    shape = c("dot", "square"),
                    size = 10:15, color = c("blue", "red"))
edges <- data.frame(from = 1:5, to = c(5, 4, 6, 3, 3))
visNetwork(nodes, edges) %>%
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)

#networkD3 -----
install.packages("networkD3")
library(networkD3)
data(MisLinks, MisNodes)
forceNetwork(Links = MisLinks, Nodes = MisNodes, Source = "source",
             Target = "target", Value = "value", NodeID = "name",
             Group = "group", opacity = 0.4)
#d3heatmap----
install.packages("d3heatmap")
library(d3heatmap)
d3heatmap(mtcars, scale="column", colors="Blues")

#DataTables ----
library(DT)
datatable(iris, options = list(pageLength = 5))

# threejs ----
library(threejs)
z <- seq(-10, 10, 0.01)
x <- cos(z)
y <- sin(z)
scatterplot3js(x,y,z, color=rainbow(length(z)))


# rglwidget renders WebGL scenes created with the rgl package.

library(rgl)
library(rglwidget)
library(htmltools)

theta <- seq(0, 6*pi, len=100)
xyz <- cbind(sin(theta), cos(theta), theta)
lineid <- plot3d(xyz, type="l", alpha = 1:0, 
                 lwd = 5, col = "blue")["data"]

browsable(tagList(
  rglwidget(elementId = "example", width = 500, height = 400,
            controllers = "player"),
  playwidget("example", 
             ageControl(births = theta, ages = c(0, 0, 1),
                        objids = lineid, alpha = c(0, 1, 0)),
             start = 1, stop = 6*pi, step = 0.1, 
             rate = 6,elementId = "player")
))



# DiagrammeR -----
# A tool for creating diagrams and flowcharts using Graphviz and Mermaid.
library(DiagrammeR)
grViz("
  digraph {
    layout = twopi
    node [shape = circle]
    A -> {B C D} 
  }")



# MetricsGraphics enables easy creation of D3 scatterplots, line charts, and histograms. ----
library(metricsgraphics)
mjs_plot(mtcars, x=wt, y=mpg) %>%
  mjs_point(color_accessor=carb, size_accessor=carb) %>%
  mjs_labs(x="Weight of Car", y="Miles per Gallon")






