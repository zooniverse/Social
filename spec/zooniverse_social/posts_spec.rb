module ZooniverseSocial
  RSpec.describe Posts do
    describe '#initialize' do
      it 'should use an Updater' do
        expect(Updater).to receive(:new).with(
          'https://public-api.wordpress.com', '/rest/v1.1/sites/36711287/posts'
        ).and_return double update: { }
        subject
      end

      it 'should update' do
        allow_any_instance_of(Posts).to receive :update
        expect(subject).to have_received :update
      end
    end

    describe '#update' do
      let(:sample_response) do
        {
          'posts' => [{
            'ID' => 123,
            'title' => 'title',
            'date' => 'now',
            'URL' => 'url'
          }]
        }
      end

      it 'should call the updater' do
        expect_any_instance_of(Updater).to receive(:update)
          .at_least(:once)
          .with(number: 3, fields: 'ID,URL,title,date')
          .and_return sample_response
        subject.update
      end

      it 'should format the data' do
        expect_any_instance_of(Updater).to receive(:update)
          .at_least(:once)
          .and_return sample_response
        subject.update
        expect(subject.data).to eql [{
          id: 123,
          title: 'title',
          created_at: 'now',
          link: 'url'
        }]
      end
    end
  end
end
