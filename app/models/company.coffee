App.Company = DS.Model.extend
  _id           : DS.attr 'string'
  amount_raised : DS.attr 'number'

  didLoad  : -> console.log "didLoad link:"  , @get('url')
  didUpdate: -> console.log "didUpdate link:", @get('title')
  didCreate: -> console.log "didCreate link:", @get('title')
