#################################################
## VIEWS
#################################################

require 'views/home'
require 'views/chart'

App.ApplicationView = Em.View.extend
  didInsertElement: -> @$().hide().fadeIn('slow')
  templateName: require 'templates/application'
