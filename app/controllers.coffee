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
  maxResults: 20
  maxResultsPossible: [10..50]
  hover: false
  fetch: (() ->
    q   = @get('query') or "*"    # so that "" becomes "*"
    max = @get('maxResults')
    @set('content', App.store.findQuery(App.Company, {q, max}))
  ).observes('query', 'maxResults')
  selected: (() ->
    if @get('hover')
      console.log @get('hover')
      App.store.find(App.Company, @get('hover'))
    else
      false
  ).property('hover')
