require 'spec_helper'

describe HolidayCache do
  describe '#store' do
    let(:mock_redis) { double }
    let(:holiday) {
      {
        start_date: Date.new(2014, 2, 11)
      }
    }

    before do
      Redis.stub(:current).and_return(mock_redis)
      HolidayList.stub(:list).and_return([holiday])
    end

    it 'stores results in redis' do
      mock_redis.should_receive(:zadd).with('vacay_me::holidays', 1392098400, holiday)
      subject.store
    end

    it 'doesnt add to redis if the key hasnt changed'

    it 'removes old keys'
  end
end
