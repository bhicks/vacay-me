VacayMe.Holiday = DS.Model.extend
  name: DS.attr('string')
  selected: DS.attr('boolean')
  date: DS.attr('date')

VacayMe.Holiday.FIXTURES = [
  {
    id: 1,
    name: 'Christmas',
    selected: true,
    date: '12/25/2013'
  },{
    id: 2,
    name: 'July 4th',
    selected: true,
    date: '7/4/2014'
  },{
    id: 3,
    name: 'Arbor Day',
    selected: false,
    date: '4/29/2014'
  }
]
