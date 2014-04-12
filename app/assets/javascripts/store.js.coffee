VacayMe.Store = DS.Store.extend
  revision: 11
  adapter: DS.FixtureAdapter.create()

DS.FixtureAdapter.configure('plurals', holiday: 'holidays')
