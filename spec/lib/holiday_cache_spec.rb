require 'spec_helper'

describe HolidayCache do
  let(:mock_redis) { double.as_null_object }
  let(:holiday) {
    {
      start_date: Date.new(2014, 2, 11)
    }
  }

  before do
    Redis.stub(:current).and_return(mock_redis)
    HolidayList.stub(:list).and_return([holiday])
  end

  describe '#store' do
    it 'stores results in redis' do
      mock_redis.should_receive(:zadd).with(HolidayCache::KEY, 1392098400, holiday)
      subject.store
    end

    it 'doesnt add to redis if the key hasnt changed'

    it 'removes old keys' do
      subject.should_receive(:clear_passed)
      subject.store
    end
  end

  describe '#clear_passed' do
    before do
      Timecop.freeze Time.local(2014, 04, 14, 12, 0, 0)
    end

    after do
      Timecop.return
    end

    it 'removes old holidays from redis' do
      mock_redis.should_receive(:zrangebyscore).with(HolidayCache::KEY, 0, 1397408400).and_return([holiday])
      mock_redis.should_receive(:zrem).with('vacay_me::holidays', holiday)
      subject.clear_passed
    end

    it 'does not remove new holidays from redis' do
      mock_redis.should_receive(:zrangebyscore).with(HolidayCache::KEY, 0, 1397408400).and_return([])
      mock_redis.should_not_receive(:zrem)
      subject.clear_passed
    end
  end
end
