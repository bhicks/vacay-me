require 'spec_helper'

describe HolidayCache do
  before(:all) do
    Timecop.freeze Time.local(2014, 04, 14, 12, 0, 0)
  end

  after(:all) do
    Timecop.return
  end

  let(:mock_redis) { double.as_null_object }
  let(:holiday) do
    {
      start_date: Date.new(2014, 2, 11)
    }
  end

  before do
    Redis.stub(:current).and_return(mock_redis)
    HolidayList.stub(:list).and_return([holiday])
  end

  describe '#store' do
    it 'stores results in redis' do
      mock_redis
        .should_receive(:zadd)
        .with(HolidayCache::KEY, 1_392_098_400, holiday.to_json)
      subject.store
    end

    it 'doesnt add to redis if the key hasnt changed'

    it 'removes old keys' do
      subject.should_receive(:clear)
      subject.store
    end
  end

  describe '#clear' do
    it 'respects a start option'

    it 'respects an end option'

    it 'clears everything without options' do
      mock_redis.should_receive(:del).with(HolidayCache::KEY)
      subject.clear
    end
  end

  describe '#retrieve' do
    it 'returns hash with symbols as keys'

    it 'uses 1 year from now in zrangebyscore call without params' do
      mock_redis
        .should_receive(:zrangebyscore)
        .with(HolidayCache::KEY, 1_397_494_800, 1_429_030_800)
      subject.retrieve
    end

    it 'uses the param in zrangebyscore call with a time param' do
      mock_redis
        .should_receive(:zrangebyscore)
        .with(HolidayCache::KEY, 1_397_494_800, 1_408_035_600)
      subject.retrieve Time.local(2014, 8, 14, 12, 0, 0)
    end

    it 'raises an error with a non-time param' do
      expect do
        subject.retrieve 'foobar'
      end.to raise_error(ArgumentError)
    end
  end
end
