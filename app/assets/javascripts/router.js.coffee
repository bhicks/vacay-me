VacayMe.Router.map ->
  @route 'holidays', path: '/'

VacayMe.HolidaysRoute = Ember.Route.extend
  model: ->
    @store.find('holiday')
