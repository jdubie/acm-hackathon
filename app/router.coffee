App = require 'app'

App.Router.map (match) ->
  match('/').to('home')
  match('/chart').to('chart')

App.HomeRoute = Em.Route.extend
  setupControllers: (controller) ->
    controller.set('content', App.store.find(App.Company))

App.ChartRoute = Em.Route.extend
  setupControllers: (controller) ->
    controller.set('content', App.store.findQuery(App.Company, name: '*'))
    #controller.set('content', App.store.find(App.Company))
