#################################################
## CONTROLLERS
#################################################

App.ApplicationController = Em.Controller.extend
  currentUser: null

App.HomeController = Em.ArrayController.extend
  content: null
