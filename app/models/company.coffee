App.Company = DS.Model.extend
  name          : DS.attr 'string'
  description   : DS.attr 'string'
  small_image_s : DS.attr 'string'

  number_of_employees_i : DS.attr 'number'
  months_since_raise_i  : DS.attr 'number'
  amount_raised_d       : DS.attr 'number' # TODO make this *_d
  founded_year_i        : DS.attr 'number'
  # @todo: make this a hasMany??
  investors_txt         : DS.attr 'array'

  number_of_employees: (() ->
    @get('number_of_employees_i')
  ).property('number_of_employees_i')
  months_since_raise: (() ->
    @get('months_since_raise_i')
  ).property('months_since_raise_i')
  amount_raised: (() ->
    @get('amount_raised_d')
  ).property('amount_raised_d')
  year_founded: (->
    @get('founded_year_i')
  ).property('founded_year_i')
  investors: (->
    @get('investors_txt')
  ).property('investors_txt')

  imageUrl: (() ->
    'http://crunchbase.com/' + @get('small_image_s')
  ).property('small_image_s')

  #didLoad : ->
  #  console.log "didLoad", @get('id'), @get('number_of_employees'), @get('months_since_raise'), @get('amount_raised')
  didUpdate              : -> console.log "didUpdate link                            : ", @get('title')
  didCreate              : -> console.log "didCreate link                            : ", @get('title')
