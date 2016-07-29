require 'spec_helper'

describe FormStalker::Request do
  describe '.get' do
    context 'when using an invalid oauth_token' do
      let(:bad_connection) { FormStalker::Connection.new({}) }
      let(:request) { described_class.new(bad_connection) }

      before do
        VCR.use_cassette('invalid_oauth_token') do
          @response = request.get('form/1.json')
        end
      end

      it '@response should have an error' do
        expect(@response.error).to eq \
          'Either your oauth token is invalid ' \
          "or you don't have access to this resource"
      end
    end
  end
end
