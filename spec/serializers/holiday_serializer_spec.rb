require 'spec_helper'
# require 'holiday_serializer'

describe HolidaySerializer do
  subject { HolidaySerializer.new(params).to_json }

  let(:params) do
    {
      summary:    'Fake holiday',
      start_date: Date.parse('2014-04-16')
    }
  end

  describe 'json' do
    let(:json) { JSON.parse subject }

    it 'has a name key' do
      json['name'].should == 'Fake holiday'
    end

    it 'has a date key' do
      json['date'].should == '04/16/2014'
    end
  end
end
