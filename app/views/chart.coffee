App.ChartView = Em.View.extend
  templateName: require 'templates/chart'
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
      @get('controller').set('hover', data.id)
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

    MAX_RAD = 50

    dim =
      r: 'number_of_employees'
      x: 'months_since_raise'
      y: 'amount_raised'
    rScale = d3.scale.pow().exponent(0.5)
      .domain([0, d3.max(companies.mapProperty(dim.r))])
      .range([2, MAX_RAD])

    xScale = d3.scale.linear()
      .domain([d3.min(companies.mapProperty(dim.x)), 0])
      .range([MAX_RAD, svgWidth - MAX_RAD])

    yScale = d3.scale.linear()
      .domain([0, d3.max(companies.mapProperty(dim.y))])
      .range([MAX_RAD, svgHeight - MAX_RAD])

    cnodes = companies.map (c) ->
      data =
        id     : c.get('permalink')
        x      : xScale(c.get(dim.x))
        y      : svgHeight - yScale(c.get(dim.y))
        radius : rScale(c.get(dim.r))
      createCircle(data.x, data.y, data.radius)
      data

  ).observes('controller.content.isUpdating')
