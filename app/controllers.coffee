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
  query: null
  fetch: (() ->
    @set('content', App.store.findQuery(App.Company, q: @get('query')))
  ).observes('query')
