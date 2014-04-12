VacayMe.HolidayController = Ember.ObjectController.extend
  actions:
    toggleSelected: ->
      if @get('selected')
        @set('selected', false)
      else
        @set('selected', true)
