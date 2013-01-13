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

    dim =
      r: 'number_of_employees'
      x: 'months_sinces_raise'
      y: 'amount_raised'

    rScale = d3.scale.pow().exponent(0.5)
      .domain([0, d3.max(companies.mapProperty(dim.r))])
      .range([2, 85])

    xScale = d3.scale.linear()
      .domain([0, d3.max(companies.mapProperty(dim.x))])
      .range([0, center.x])

    yScale = d3.scale.linear()
      .domain([0, d3.max(companies.mapProperty(dim.y))])
      .range([0, center.y])

    cnodes = companies.map (c) ->
      funding = radius_scale(c.get('amount_raised'))
      data =
        id     : c.get('id')
        x      : xScale(c.get(dim.x))
        y      : yScale(c.get(dim.y))
        radius : rScale(c.get(dim.r))
      createCircle(data.x, data.y, data.radius)
      data

  ).observes('controller.content.isUpdating')
