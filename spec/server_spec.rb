RSpec.describe Server, type: :server do
  subject{ last_response }

  before :each do
    allow(Data).to receive(:current).and_return data: true
    get '/'
  end

  it{ is_expected.to be_ok }
  its(:content_type){ is_expected.to eql 'application/json' }
  its(:body){ is_expected.to eql JSON.dump data: true }
end
