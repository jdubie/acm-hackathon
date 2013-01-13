App = require 'app'

App.Router.map (match) ->
  match('/').to('home')

App.HomeRoute = Em.Route.extend
  setupControllers: (controller) ->
    controller.set('content', App.store.find(App.Company))
