# Application bootstrapper

App = Em.Application.create()

# create Ember Data store
App.store = DS.Store.create
  revision: 10
  adapter: DS.RESTAdapter.create
    bulkCommit: false
    plurals:
      company: 'companies'
    serializer: DS.JSONSerializer.extend
      primaryKey: (type) -> 'id'

# https://github.com/emberjs/data/issues/504
#App.store.adapter.serializer.map 'App.Post', user: {embedded: 'load'}, link: {embedded: 'load'}

module.exports = App
