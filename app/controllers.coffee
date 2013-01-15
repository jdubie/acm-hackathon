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
  category: ""
  categoryPossible: [
    "Category"
    "advertising"
    "biotech"
    "cleantech"
    "hardware"
    "web"
    "ecommerce"
    "education"
    "enterprise"
    "games_video"
    "mobile"
    "network_hosting"
    "search"
    "security"
    "semiconductor"
    "software"
    "other"
  ]
  maxResults: 20
  maxResultsPossible: [10..50]
  hover: false
  fetch: (() ->
    q        = @get('query') or "*"       # so "" => "*"
    category = @get('category')
    category = "*" if category in ["Category", ""]
    max      = @get('maxResults')
    query    = {q, max, category}
    @set('content', App.store.findQuery(App.Company, query))
  ).observes('query', 'maxResults', 'category')
  selected: (() ->
    if @get('hover')
      console.log @get('hover')
      App.store.find(App.Company, @get('hover'))
    else
      false
  ).property('hover')
