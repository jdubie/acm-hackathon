App = require 'app'

App.Router.map (match) ->
  match('/').to('home')
<<<<<<< HEAD
  match('/profile').to('profile')
  match('/circle').to('circle')
=======
>>>>>>> f1aa108ca61da7fa478483f466d74fbf75bdd49a

App.HomeRoute = Em.Route.extend
  setupControllers: (controller) ->
    for i in [0..10]
      App.Company.createRecord({ _id: i, amount_raised: Math.random()*1000000})
    controller.set('content', App.store.all(App.Company))
