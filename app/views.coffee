#################################################
## VIEWS
#################################################

App.ApplicationView = Em.View.extend
  didInsertElement: -> @$().hide().fadeIn('slow')
  templateName: require 'templates/application'

App.HomeView = Em.View.extend
  templateName: require 'templates/home'
  didInsertElement: ->
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

    createCircle(100, 50)
    createCircle(100, 150)
