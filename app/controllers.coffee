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
  hover: false
  fetch: (() ->
    @set('content', App.store.findQuery(App.Company, q: @get('query')))
  ).observes('query')
  selected: (() ->
    if @get('hover')
      console.log @get('hover')
      App.store.find(App.Company, @get('hover'))
    else
      false
  ).property('hover')
