App.Company = DS.Model.extend
  permalink     : DS.attr 'string'
  amount_raised : DS.attr 'number'
  name          : DS.attr 'string'
  number_of_employees: DS.attr 'number'
  months_since_raise: DS.attr 'number'

  category_code           : DS.attr 'string'
  number_of_employees     : DS.attr 'number'
  founded_year            : DS.attr 'number'
  description             : DS.attr 'string'
  overview                : DS.attr 'string'
  image                   : DS.attr 'string'
  crunchbase_url          : DS.attr 'string'
  number_good_investors   : DS.attr 'number'
  lifeswap_URL            : DS.attr 'string'

  small_image_s: DS.attr 'string'
  number_of_employees_i: DS.attr 'number'
  months_since_raise_i: DS.attr 'number'

  number_of_employees: (() ->
    @get('number_of_employees_i')
  ).property('number_of_employees_i')
  months_since_raise: (() ->
    @get('months_since_raise_i')
  ).property('months_since_raise_i')


  imageUrl                : (() ->
    'http://crunchbase.com/' + @get('image')
  ).property('image')

  didLoad : -> console.log "didLoad link: "  , @get('id')
  didUpdate              : -> console.log "didUpdate link                            : ", @get('title')
  didCreate              : -> console.log "didCreate link                            : ", @get('title')
