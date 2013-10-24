VacayMe.Router.map ->
  @route 'holidays', path: '/'

VacayMe.HolidaysRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set('content', [{
        name: 'Christmas',
        selected: true,
        date: '12/25/2013'
      },{
        name: 'July 4th',
        selected: true,
        date: '7/4/2014'
      },{
        name: 'Arbor Day',
        selected: false,
        date: '4/29/2014'
      }]
    )
