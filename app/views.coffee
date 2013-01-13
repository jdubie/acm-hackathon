#################################################
## VIEWS
#################################################

App.ApplicationView = Em.View.extend
  didInsertElement: -> @$().hide().fadeIn('slow')
  templateName: require 'templates/application'

App.HomeView = Em.View.extend
  templateName: require 'templates/home'
  createVisualization: (() ->
    return if @get('controller').get('content').get('isUpdating')
      
    svgWidth = 500
    svgHeight = 500
    center =
      x: svgWidth / 2
      y: svgHeight / 2

    svg = d3.select("#viz")
      .append("svg")
      .attr("width", svgWidth)
      .attr("height", svgHeight)

    showDetails = (data, id, elem) =>
      @get('controller').set('hover', data._id)
    hideDetails = (data, id, elem) =>
      @get('controller').set('hover', false)

    createCircle = (x, y, r) ->
      svg.append("circle")
        .style("stroke", "black")
        .style("fill", "gray")
        .attr("r", r)
        .attr("cx", x)
        .attr("cy", y)
        .on("mouseover", (d,i) -> showDetails(d, i, this))
        .on("mouseout", (d,i) -> hideDetails(d, i, this))

    companies = @get('controller').get('content')
    sum = 0

    amountsRaised = companies.mapProperty('amount_raised')
    max_amount = d3.max(amountsRaised)
    radius_scale = d3.scale.pow().exponent(0.5).domain([0, max_amount]).range([2, 85])

    cnodes = companies.map (c) ->
      funding = radius_scale(c.get('amount_raised'))
      data =
        _id: c.get('_id')
        x: Math.random() * svgWidth
        y: Math.random() * svgHeight
        radius: funding
      createCircle(data.x, data.y, data.radius)
      data

    #####################
    ## Animate them
    #####################
    damper = 0
    _charge = (d) ->
      -Math.pow(d.radius, 2.0) / 8

    move_towards_center = (alpha) ->
      (d) ->
        d.x = d.x + (center.x - d.x) * .12 * alpha
        d.y = d.y + (center.y - d.y) * .12 * alpha

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

  ).observes('controller.content.isUpdating')
