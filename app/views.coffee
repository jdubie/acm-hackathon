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

    #radius_scale = d3.scale.pow().exponent(0.5).domain([0, max_amount]).range([2, 85])

    cnodes = companies.map (c) ->
      funding = 3*c.get('_id')
      #funding = Math.log(c.get('amount_raised'))
      sum += 2*funding
      createCircle(sum, sum, funding)
      { x: sum, y: sum, radius: 2*funding }

    #####################
    ## Animate them
    #####################
    damper = 0
    _charge = (d) ->
      -Math.pow(d.radius, 2.0) / 8

    move_towards_center = (alpha) ->
      (d) ->
        d.x = d.x + (250 - d.x) * .12 * alpha
        d.y = d.y + (250 - d.y) * .12 * alpha

    circles = d3.selectAll('circle')
      .data(cnodes)

    force = d3.layout.force()
      .nodes(cnodes)
      .size([250, 250])

    force.gravity(-.01)
      .charge(_charge)
      .friction(0.9)
      .on "tick", (e) =>
        circles.each(move_towards_center(e.alpha))
          .attr("cx", (d) -> d.x)
          .attr("cy", (d) -> d.y)
    force.start()

    
    
