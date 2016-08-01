require 'spec_helper'

describe FormStalker::Client do
  describe '.new' do
    context 'when sending configuration options' do
      let(:client) { described_class.new(oauth_token: '123') }

      it 'client.config.oauth_token should reflect that initialization' do
        expect(client.config.oauth_token).to eq '123'
      end
    end

    context 'when sending a Config instance' do
      let(:client) do
        described_class.new(FormStalker::Config.new(oauth_token: '1234'))
      end

      it 'client.config.oauth_token should reflect that initialization' do
        expect(client.config.oauth_token).to eq '1234'
      end
    end
  end
end
