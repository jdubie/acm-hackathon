App.ChartView = Em.View.extend
  templateName: require 'templates/chart'
  svgWidth: 750
  svgHeight: 550
  svg: null
  didInsertElement: ->
    svg = d3.select("#viz")
      .append("svg")
      .attr("width", @get('svgWidth'))
      .attr("height", @get('svgHeight'))
    @set('svg', svg)

  createVisualization: (() ->
    isLoaded = @get('controller').get('content').get('isLoaded')
    return unless isLoaded

    svgWidth = @get('svgWidth')
    svgHeight = @get('svgHeight')
    center =
      x: svgWidth / 2
      y: svgHeight / 2

    svg = @get('svg')

    # clean up old state
    svg.selectAll('circle').remove()

    showDetails = (data, i, elem, id) =>
      @get('controller').set('hover', id)
    hideDetails = ->

    createCircle = (x, y, r, id) ->
      svg.append("circle")
        .style("stroke", "black")
        .style("fill", "gray")
        .attr("r", r)
        .attr("cx", x)
        .attr("cy", y)
        .on("mouseover", (d,i) -> showDetails(d, i, this, id))
        .on("mouseout", (d,i) -> hideDetails(d, i, this, id))

    companies = @get('controller').get('content')

    MAX_RAD = 50

    dim =
      r: 'number_of_employees'
      x: 'months_since_raise'
      y: 'amount_raised'

    rScale = d3.scale.pow().exponent(0.5)
      .domain([0, d3.max(companies.mapProperty(dim.r))])
      .range([2, MAX_RAD])

    xScale = d3.scale.linear()
      .domain([
        d3.min(companies.mapProperty(dim.x))
        d3.max(companies.mapProperty(dim.x))
        ])
      .range([MAX_RAD, svgWidth - MAX_RAD])

    yScale = d3.scale.linear()
      .domain([
        d3.min(companies.mapProperty(dim.y))
        d3.max(companies.mapProperty(dim.y))
      ])
      .range([MAX_RAD, svgHeight - MAX_RAD])

      #console.log companies.mapProperty(dim.y).map(yScale)
      #console.log companies.mapProperty(dim.x).map(xScale)

    cnodes = companies.map (c) ->
      data =
        id     : c.get('id')
        x      : svgWidth - xScale(c.get(dim.x))
        y      : svgHeight - yScale(c.get(dim.y))
        radius : rScale(c.get(dim.r))
      createCircle(data.x, data.y, data.radius, data.id)
      data

  ).observes('controller.content.isLoaded', 'controller.content.query')
