RSpec.describe Statuses do
  describe '#initialize' do
    it 'should use an Updater' do
      expect(Updater).to receive(:new).with(
        'https://graph.facebook.com', '/v2.5/162907460488617/posts'
      ).and_return double update: { }
      subject
    end

    it 'should update' do
      allow_any_instance_of(Statuses).to receive :update
      expect(subject).to have_received :update
    end
  end

  describe '#update' do
    let(:sample_response) do
      {
        'data' => [{
          'id' => 'foo_123',
          'message' => 'message',
          'created_time' => 'now'
        }]
      }
    end

    it 'should call the updater' do
      expect_any_instance_of(Updater).to receive(:update)
        .at_least(:once)
        .with(access_token: 'facebook_token', limit: 3)
        .and_return sample_response
      subject.update
    end

    it 'should format the data' do
      expect_any_instance_of(Updater).to receive(:update)
        .at_least(:once)
        .and_return sample_response
      subject.update
      expect(subject.data).to eql [{
        message: 'message',
        created_at: 'now',
        link: 'https://www.facebook.com/therealzooniverse/posts/123'
      }]
    end
  end
end
