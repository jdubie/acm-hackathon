#################################################
## VIEWS
#################################################

App.ApplicationView = Em.View.extend
  didInsertElement: -> @$().hide().fadeIn('slow')
  templateName: require 'templates/application'

App.HomeView = Em.View.extend
  didInsertElement: -> @$().hide().fadeIn('slow')
  templateName: require 'templates/home'
  testFoo: (a,b) ->
    this.get('controller').set('link', a.context)

App.ProfileView = Em.View.extend
  templateName: require('templates/profile')

App.NavbarView = Em.View.extend
  templateName: require 'templates/navbar'

App.CircleView = Em.View.extend
  templateName: require 'templates/circle'

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

    createCircle(150,150)
