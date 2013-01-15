App.ChartView = Em.View.extend
  templateName: require 'templates/chart'
  svgWidth: 750
  svgHeight: 550
  svg: null
  didInsertElement: ->
    ## svg canvas
    svg = d3.select("#viz")
      .append("svg")
      .attr("width", @get('svgWidth'))
      .attr("height", @get('svgHeight'))
    ## axes labels
    svg.append("text")
      .attr("class", "x label")
      .attr("text-anchor", "end")
      .attr("x", @get('svgWidth'))
      .attr("y", @get('svgHeight') - 6)
      .text("Months since last raise")
    svg.append("text")
      .attr("class", "y label")
      .attr("text-anchor", "end")
      .attr("y", 6)
      .attr("dy", ".75em")
      .attr("transform", "rotate(-90)")
      .text("Amount Raised ($)")

    defs = svg.append('svg:defs')
    defs.append('svg:radialGradient')
      .attr("id", "radial")
      .attr("cx", "50%")
      .attr("cy", "50%")
      .attr("r", "50%")
      .attr("fx", "50%")
      .attr("fy", "50%")
      .call (gradient) ->
        gradient.append("svg:stop")
          .attr("offset", "0%")
          .attr("style", "stop-color:rgb(255,255,255); stop-opacity:0")
        gradient.append("svg:stop")
          .attr("offset", "100%")
          .attr("style", "stop-color:rgb(54,175,167); stop-opacity:1")

    @set('svg', svg)

  createVisualization: (() ->
    isLoaded = @get('controller').get('content').get('isLoaded')
    return unless isLoaded

    svgWidth  = @get('svgWidth')
    svgHeight = @get('svgHeight')
    MAX_RAD   = 40
    pad       = MAX_RAD + 5
    padding   =
      top   : pad
      left  : pad * 3
      right : pad
      bottom: pad * 2

    svg = @get('svg')

    # clean up old state
    svg.selectAll("circle").remove()
    svg.selectAll("g").remove()

    showDetails = (data, i, elem, id) =>
      @get('controller').set('hover', id)
    hideDetails = ->

    createCircle = (x, y, r, id) ->
      svg.append("circle")
        .style("fill", "url(#radial)")
        .attr("r", r)
        .attr("cx", x)
        .attr("cy", y)
        .on("mouseover", (d,i) -> showDetails(d, i, this, id))
        .on("mouseout", (d,i) -> hideDetails(d, i, this, id))

    companies = @get('controller').get('content')

    dim =
      r: 'number_of_employees'
      x: 'months_since_raise'
      y: 'amount_raised'

    rScale = d3.scale.pow().exponent(0.5)
      .domain([0, d3.max(companies.mapProperty(dim.r))])
      .range([2, MAX_RAD])

    xScale = d3.scale.linear()
      .domain([
        d3.max(companies.mapProperty(dim.x))
        d3.min(companies.mapProperty(dim.x))
      ])
      .range([padding.left, svgWidth - padding.right])

    yScale = d3.scale.linear()
      .domain([
        d3.max(companies.mapProperty(dim.y))
        d3.min(companies.mapProperty(dim.y))
      ])
      .range([padding.top, svgHeight - padding.bottom])

    ## x-axis
    xAxis = d3.svg.axis()
      .scale(xScale)
      .orient("bottom")
      .ticks(5)
    svg.append("g")
      .attr("class", "axis")
      .attr("transform", "translate(0,#{svgHeight - MAX_RAD})")
      .call(xAxis)
    ## y-axis
    yAxis = d3.svg.axis()
      .scale(yScale)
      .orient("left")
      .ticks(5)
    svg.append("g")
      .attr("class", "axis")
      .attr("transform", "translate(#{MAX_RAD * 2},0)")
      .call(yAxis)


      #console.log companies.mapProperty(dim.y).map(yScale)
      #console.log companies.mapProperty(dim.x).map(xScale)

    cnodes = companies.map (c) ->
      data =
        id     : c.get('id')
        x      : xScale(c.get(dim.x))
        y      : yScale(c.get(dim.y))
        radius : rScale(c.get(dim.r))
      createCircle(data.x, data.y, data.radius, data.id)
      data

  ).observes('controller.content.isLoaded', 'controller.content.query')
