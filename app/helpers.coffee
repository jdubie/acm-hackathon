# load helpers

Handlebars.registerHelper 'breakLines', (property, options) ->
  value = Ember.Handlebars.get(this, property, options)
  new Handlebars.SafeString(value.split('\n').join('<br/>'))

# @todo there's something wrong w/ doing this... look it up.
App.store.adapter.registerTransform 'array',
  deserialize: (serialized) -> serialized
  serialize: (deserialized) -> deserialized
