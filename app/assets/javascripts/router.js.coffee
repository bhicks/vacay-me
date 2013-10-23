VacayMe.Router.map ->
  @route 'holidays', path: '/'

VacayMe.HolidaysRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set('holidays', [])
    # controller.set('holidays', [{
    #                              name: 'Christmas',
    #                              date: '12/25/2013'
    #                            },{
    #                              name: 'July 4th',
    #                              date: '7/4/2013'
    #                            }])
