window.App = require 'app'

require 'models'
require 'controllers'
require 'views'
require 'router'
require 'helpers'

document.write('<div id="viz"></div>')

svg = d3.select("#viz")
  .append("svg")
  .attr("width", 500)
  .attr("height", 250)

createCircle = (x, y) ->
  svg.append("circle")
    .style("stroke", "gray")
    .style("fill", "white")
    .attr("r", 50)
    .attr("cx", x)
    .attr("cy", y)

createCircle(150,150)

circle = svg.selectAll('circle')

##################################################
## 
##################################################

App.CircleModel = Em.Object.extend
  radius: 50
  rad: (() ->
    @get('radius')
    console.log 'hwewef'
  ).property('radius')

circle.attr 'r', Ember.Binding.oneWay("App.Circle.radius")


App.Circle = new App.CircleModel()

##################################################
## 
##################################################

