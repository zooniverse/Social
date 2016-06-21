module ZooniverseSocial
  RSpec.describe Tweets do
    describe '#initialize' do
      it 'should use the Twitter client' do
        expect(Twitter::REST::Client).to receive(:new).with(
          consumer_key: 'twitter_key', consumer_secret: 'twitter_secret'
        ).and_return double search: { }
        subject
      end

      it 'should update' do
        allow_any_instance_of(Tweets).to receive :update
        expect(subject).to have_received :update
      end
    end

    describe '#update' do
      it 'should search Twitter' do
        expect_any_instance_of(Twitter::REST::Client).to receive(:search)
          .at_least(:once)
          .with('from:the_zooniverse', result_type: 'recent')
          .and_return({ })
        subject.update
      end
    end
  end
end
