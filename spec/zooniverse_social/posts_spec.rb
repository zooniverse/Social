module ZooniverseSocial
  RSpec.describe Posts do
    before(:each) do
      allow(Updater).to receive(:new).with(
        'https://public-api.wordpress.com', '/rest/v1.1/sites/36711287/posts'
      ).and_return blog_updater

      expect(Updater).to receive(:new).with(
        'https://public-api.wordpress.com', '/rest/v1.1/sites/57182749/posts'
      ).and_return daily_updater
    end

    let(:blog_updater){ double update: blog_response }
    let(:daily_updater){ double update: daily_response }

    let(:blog_response){ { } }
    let(:daily_response){ { } }

    describe '#initialize' do
      it 'should use an Updater' do
        expect(subject.instance_variable_get(:@blog_updater)).to eql blog_updater
        expect(subject.instance_variable_get(:@daily_updater)).to eql daily_updater
        subject
      end

      it 'should update' do
        subject
        expect(blog_updater).to have_received :update
        expect(daily_updater).to have_received :update
      end
    end

    describe '#update' do
      let(:blog_response) do
        {
          'posts' => [{
            'ID' => 123,
            'title' => '&#8220;title1&#8221;&#8217;',
            'excerpt' => '<p>excerpt1[&hellip;]&#33;</p>',
            'date' => '1',
            'URL' => 'url1'
          }]
        }
      end

      let(:daily_response) do
        {
          'posts' => [{
            'ID' => 456,
            'title' => 'title2',
            'excerpt' => '<p>excerpt2[&hellip;]&#33;</p>',
            'date' => '2',
            'URL' => 'url2'
          }]
        }
      end

      it 'should call the updaters' do
        [blog_updater, daily_updater].each do |updater|
          expect(updater).to receive(:update)
            .at_least(:once)
            .with(number: 3, fields: 'ID,URL,title,excerpt,date')
        end
        subject.update
      end

      it 'should format the data' do
        subject.update
        expect(subject.data).to eql [{
          id: 456,
          title: 'title2',
          excerpt: 'excerpt2!',
          created_at: '2',
          link: 'url2'
        }, {
          id: 123,
          title: 'title1',
          excerpt: 'excerpt1!',
          created_at: '1',
          link: 'url1'
        }]
      end
    end
  end
end
