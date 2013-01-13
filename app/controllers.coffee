#################################################
## CONTROLLERS
#################################################

App.ApplicationController = Em.Controller.extend
  currentUser: null

App.ProfileController = Em.ObjectController.extend
  content: null

App.CircleController = Em.ObjectController.extend
  content: null

  updateCircle: (() ->
    svg = d3.select("#viz")
    circle = svg.selectAll('circle')
    circle.attr("r", @get('radius'))
  ).observes('radius')
