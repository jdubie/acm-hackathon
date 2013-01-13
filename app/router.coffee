App = require 'app'
debug = require('debug') 'DEBUG router'

#App.Route = Em.Router.extend
#  rootUrl: '/'
#  enableLogging: true
#  location: 'history'

App.Router.map (match) ->
  match('/').to('home')
  match('/profile').to('profile')

App.HomeRoute = Em.Route.extend {}
  setupControllers: (controller) ->
    #controller.set('posts', App.store.findAll(App.Example))

App.ProfileRoute = Em.Route.extend
  setupControllers: (controller) ->
    controller.set('content', App.CurrentUser)
