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
  categoryText: "Category"
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
  fetch: (() ->
    q        = @get('query') or "*"       # so "" => "*"
    category = @categoryMap[@get('categoryText')]
    max      = @get('maxResults')
    query    = {q, max, category}
    @set('content', App.store.findQuery(App.Company, query))
  ).observes('query', 'maxResults', 'categoryText')
  selected: (() ->
    if @get('hover')
      console.log @get('hover')
      App.store.find(App.Company, @get('hover'))
    else
      false
  ).property('hover')
