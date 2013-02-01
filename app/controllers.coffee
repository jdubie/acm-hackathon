#################################################
## CONTROLLERS
#################################################

App.ApplicationController = Em.Controller.extend
  currentUser: null

App.HomeController = Em.ArrayController.extend
  content: null
  hover: false
  selected: (() ->
    if @get('hover')
      App.Company.find(@get('hover'))
    else
      false
  ).property('hover')

App.ChartController = Em.ArrayController.extend
  content: null
  query: ""
  investorQuery: ""
  categoryText: (->
    "Mobile"
  ).property()
  categoryPossible: [
    "Category"
    "Advertising"
    "BioTech"
    "CleanTech"
    "Consumer Electronics"
    "Consumer Web"
    "eCommerce"
    "Education"
    "Enterprise"
    "Entertainment"
    "Mobile"
    "Network"
    "Search"
    "Security"
    "Semiconductor"
    "Software"
    "Other"
  ]
  categoryMap:
    "Category"            : "*"
    "Advertising"         : "advertising"
    "BioTech"             : "biotech"
    "CleanTech"           : "cleantech"
    "Consumer Electronics": "hardware"
    "Consumer Web"        : "web"
    "eCommerce"           : "ecommerce"
    "Education"           : "education"
    "Enterprise"          : "enterprise"
    "Entertainment"       : "games_video"
    "Mobile"              : "mobile"
    "Network"             : "network_hosting"
    "Search"              : "search"
    "Security"            : "security"
    "Semiconductor"       : "semiconductor"
    "Software"            : "software"
    "Other"               : "other"
  maxResults: 20
  maxResultsPossible: [10..50]
  hover: false

  ## founding dates (slider)
  oldestFounding: 1985    # although oldest company founded in 1800
  newestFounding: 2013
  sliderSize: (->
    @get('newestFounding') - @get('oldestFounding')
  ).property('oldestFounding', 'newestFounding')
  start: (->
    2011 - @get('oldestFounding')
  ).property()
  end  : (->
    @get('sliderSize')
  ).property()
  lower: (() ->
    @get('sliderSize') - @get('start')
  ).property('start')
  upper: (() ->
    @get('sliderSize') - @get('end')
  ).property('end')
  startYear: (() ->
    currentYear = (new Date()).getFullYear()
    currentYear - @get('lower')
  ).property('start')
  endYear: (() ->
    currentYear = (new Date()).getFullYear()
    currentYear - @get('upper')
  ).property('end')

  fetch: (() ->
    q         = @get('query') or "*"       # so "" => "*"
    investors = @get('investorQuery') or "*"
    category  = @categoryMap[@get('categoryText')]
    max       = @get('maxResults')
    startYear = @get('startYear')
    endYear   = @get('endYear')
    query     = {q, max, category, startYear, endYear, investors}
    @set('content', App.store.findQuery(App.Company, query))
  ).observes('query', 'investorQuery', 'maxResults', 'categoryText', 'startYear', 'endYear')
  selected: (() ->
    if @get('hover')
      console.log @get('hover')
      App.store.find(App.Company, @get('hover'))
    else
      false
  ).property('hover')
