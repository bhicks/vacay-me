VacayMe.HolidaysController = Ember.ArrayController.extend
  itemController: 'holiday'

  selectedHolidays: (->
    @filterProperty('selected', true)
  ).property('@each.selected')

  selectedHolidayCount: (->
    @get('selectedHolidays').get('length')
  ).property('selectedHolidays')

  inflection: (->
    count = @get('selectedHolidayCount')
    if count == 1 then 'holiday' else 'holidays'
  ).property('selectedHolidayCount')

  selectedHolidayString: (->
    selected = @get('selectedHolidays')
    if selected.get('length') <= 2
      selectedArray = selected.mapBy('name')

      selectedArray.join(' and ')
    else
      selectedArray = selected.mapBy('name')
      last          = selectedArray.pop()
      selectedArray = selectedArray.join(', ')

      selectedArray.concat(', and ' + last)
  ).property('selectedHolidays')

  hasSelectedHolidays: (->
    @get('selectedHolidayCount') > 0
  ).property('selectedHolidayCount')
