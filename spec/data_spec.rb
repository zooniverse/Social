RSpec.describe Data do
  subject{ Data }
  its(:posts){ is_expected.to be_a Posts }
  its(:tweets){ is_expected.to be_a Tweets }
  its(:statuses){ is_expected.to be_a Statuses }
  its(:sources){ is_expected.to match_array [Posts, Tweets, Statuses] }

  before :each do
    [Posts, Tweets, Statuses].each do |source|
      allow_any_instance_of(source).to receive :update
    end
  end

  describe '.current' do
    subject{ Data.current }
    its(:keys){ is_expected.to match_array [:posts, :tweets, :statuses] }

    it 'should get post data' do
      expect(Data.posts).to receive :data
      subject
    end

    it 'should get tweet data' do
      expect(Data.tweets).to receive :data
      subject
    end

    it 'should get status data' do
      expect(Data.statuses).to receive :data
      subject
    end
  end

  describe '.update' do
    it 'should update sources' do
      Data.sources.each do |source|
        expect(source).to receive :update
      end

      Data.update
    end
  end

  describe '.start' do
    let(:timer){ double execute: true }

    before :each do
      allow(Concurrent::TimerTask).to receive(:new).and_return timer
    end

    it 'should create a timer task' do
      Data.start
      expect(Concurrent::TimerTask).to have_received(:new).with({
        execution_interval: 600, run_now: true
      })
    end

    it 'should execute the task' do
      expect(timer).to receive :execute
      Data.start
    end
  end
end
