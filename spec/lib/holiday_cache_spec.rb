require 'spec_helper'

describe HolidayCache do
  before(:all) do
    Timecop.freeze Time.local(2014, 04, 14, 12, 0, 0)
  end

  after(:all) do
    Timecop.return
  end

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
      mock_redis.should_receive(:zadd).with(HolidayCache::KEY, 1392098400, holiday.to_json)
      subject.store
    end

    it 'doesnt add to redis if the key hasnt changed'

    it 'removes old keys' do
      subject.should_receive(:clear)
      subject.store
    end
  end

  describe '#clear' do
    it 'respects a start option' do

    end

    it 'respects an end option' do

    end

    it 'clears everything without options' do
      mock_redis.should_receive(:del).with(HolidayCache::KEY)
      subject.clear
    end
  end

  describe '#retrieve' do
    context 'without params' do
      it 'uses 1 year from now in zrangebyscore call' do
        mock_redis.should_receive(:zrangebyscore).with(HolidayCache::KEY, 1397494800, 1429030800)
        subject.retrieve
      end
    end

    context 'with a time param' do
      it 'uses the param in zrangebyscore call' do
        mock_redis.should_receive(:zrangebyscore).with(HolidayCache::KEY, 1397494800, 1408035600)
        subject.retrieve Time.local(2014, 8, 14, 12, 0, 0)
      end
    end

    context 'with a non-time param' do
      it 'raises an error' do
        expect {
          subject.retrieve 'foobar'
        }.to raise_error(ArgumentError)
      end
    end
  end end
