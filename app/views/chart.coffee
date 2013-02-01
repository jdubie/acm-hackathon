App.ChartView = Em.View.extend
  templateName: require 'templates/chart'
  svgWidth: (->
    @get('$svg')?.width() ? 0
  ).property()
  svgHeight: (->
    @get("$svg")?.height() ? 0
  ).property()
  svg: null
  $svg: null
  $slider: null
  didInsertElement: ->
    ## svg canvas
    @set('svgHeight', 600)
    svg = d3.select("#viz")
      .append("svg")
      .attr("width", "100%")
      .attr("height", "600")
    ## save to jquery
    @set("$svg", $("svg"))
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

    ## responsive svg!
    $(window).bind 'resize', () =>
      @set('svgWidth', @get("$svg").width())
      # @todo: remove below; doesn't actually change...
      #@set('svgHeight', @get("$svg").height())

    @set('svg', svg)

    ## jQuery UI slider
    $slider = $(".slider")
    $slider.slider
      range: true
      values: [
        @get('controller').get('start')
        @get('controller').get('end')
      ]
      max: @get('controller').get('sliderSize')
      min: 0
      step: 1
    $slider.bind 'slide', (e, ui) =>
      [start, end] = ui.values
      @get('controller').set('start', start)
      @get('controller').set('end', end)

    @set("$slider", $slider)

  willDestroyElement: ->
    $slider = @get("$slider")
    $slider.unbind("slide")
    $(window).unbind 'resize'

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

  ).observes('controller.content.isLoaded', 'controller.content.query', 'svgWidth')
