require 'spec_helper'

describe FormStalker do
  describe '.configure' do
    context 'when setting the "config.oauth_token"' do
      before do
        FormStalker.configure { |config| config.oauth_token = '123' }
      end
      after do
        FormStalker.configure { |config| config.oauth_token = nil }
      end

      it 'FormStalker.config.oauth_token should reflect that change' do
        expect(FormStalker.config.oauth_token).to eq '123'
      end

      context 'when setting the "config.oauth_token" yet again' do
        before do
          FormStalker.configure { |config| config.oauth_token = '1234' }
        end
        after do
          FormStalker.configure { |config| config.oauth_token = nil }
        end

        it 'FormStalker.config.oauth_token should reflect that change' do
          expect(FormStalker.config.oauth_token).to eq '1234'
        end
      end
    end
  end

  describe '.config' do
    context 'when setting the #oauth_token' do
      before { FormStalker.config.oauth_token = '123' }
      after { FormStalker.config.oauth_token = nil }

      it 'FormStalker.client.config.oauth_token should reflect that change' do
        expect(FormStalker.client.config.oauth_token).to eq '123'
      end
    end
  end

  describe '.client' do
    context 'when setting the #config.oauth_token' do
      before { FormStalker.client.config.oauth_token = '123' }
      after { FormStalker.client.config.oauth_token = nil }

      it 'FormStalker.config.oauth_token should reflect that change' do
        expect(FormStalker.config.oauth_token).to eq '123'
      end
    end
  end
end
