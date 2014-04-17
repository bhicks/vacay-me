require 'spec_helper'

describe HolidaysController do

  describe 'GET "index"' do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end

    it 'returns a JSON structure' do
      get 'index'
      json = JSON.parse response.body
      json['holidays'].class.should == Array
    end
  end
end
