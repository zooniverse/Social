RSpec.describe ZooniverseSocial do
  describe '.start' do
    it 'should start the data updater' do
      expect(ZooniverseSocial::Data).to receive :start
      ZooniverseSocial.start
    end
  end
end
