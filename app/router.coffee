App = require 'app'

App.Router.map (match) ->
  match('/').to('home')

App.HomeRoute = Em.Route.extend
  setupControllers: (controller) ->
    for i in [0..10]
      App.Company.createRecord({ _id: i, amount_raised: Math.random()*1000000})
    controller.set('content', App.store.all(App.Company))

