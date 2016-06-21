module ZooniverseSocial
  RSpec.describe Updater do
    subject{ Updater.new 'http://localhost', '/path' }

    describe '#update' do
      let!(:request_stub) do
        stub_request(:get, 'http://localhost/path?test=true').with(headers: {
          'Accept' => 'application/json',
          'Content-Type'=>'application/json'
        }).to_return body: '{"works":true}'
      end

      it 'should make a request' do
        subject.update test: true
        expect(WebMock).to have_requested :get, 'http://localhost/path?test=true'
      end

      it 'should parse the response' do
        expect(subject.update(test: true)).to eql 'works' => true
      end
    end
  end
end
