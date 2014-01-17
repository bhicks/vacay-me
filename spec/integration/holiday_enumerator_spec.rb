require 'spec_helper'

describe HolidayEnumerator do
  before do
    new_time = Time.local(2013, 11, 6, 12, 0, 0)
    Timecop.freeze(new_time)
  end

  after do
    Timecop.return
  end

  subject { HolidayEnumerator.new }

  context 'with an access key' do
    it { should respond_to :each }

    it 'should have holidays' do
      VCR.use_cassette 'holidays_from_november_5th_2013' do
        subject.entries.should have(30).things
      end
    end

    describe 'a holiday' do
      let(:holiday) do
        VCR.use_cassette 'holidays_from_november_5th_2013' do
          subject.first
        end
      end

      it 'summary should be Veterans day' do
        holiday[:summary].should == 'Veterans Day'
      end

      it 'start date should be 2013-11-11' do
        holiday[:start_date].should == '2013-11-11'
      end
    end
  end

  describe 'errors' do
    before do
      ENV['GOOGLE_ACCESS_KEY'] = google_access_key
    end

    context 'with a bad access key' do
      let(:google_access_key) { 'A_BAD_KEY' }

      it 'should raise an error' do
        VCR.use_cassette 'bad_google_access_key' do
          expect { subject.first }.to raise_error(ArgumentError)
        end
      end
    end

    context 'without an access key' do
      let(:google_access_key) { nil }

      it 'should raise an argument error' do
        expect { subject.first }.to raise_error(ArgumentError)
      end
    end
  end
end
