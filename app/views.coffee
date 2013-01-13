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
      .attr("height", 500)
    createCircle = (x, y, r) ->
      svg.append("circle")
        .style("stroke", "black")
        .style("fill", "gray")
        .attr("r", r)
        .attr("cx", x)
        .attr("cy", y)
    companies = @get('controller').get('content')
    sum = 0
    companies.forEach (c, i) ->
      funding = Math.log(c.get('amount_raised'))
      sum += 2*funding
      createCircle(sum, sum, funding)
