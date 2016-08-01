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

  describe '.client' do
    context 'when setting the #config.oauth_token' do
      before { FormStalker.client.config.oauth_token = '123' }
      after { FormStalker.client.config.oauth_token = nil }

      it 'FormStalker.config.oauth_token should reflect that change' do
        expect(FormStalker.config.oauth_token).to eq '123'
      end
    end
  end

  context 'setting a double for FormStalker.client' do
    before do
      @config = double('config')
      @client = double('client')

      allow(@client).to receive(:config).and_return(@config)
      allow(FormStalker).to receive(:client).and_return(@client)
    end

    describe '.form' do
      it 'double client#form should receive the same arguments' do
        expect(@client).to receive(:form).with('2178204')

        FormStalker.form('2178204')
      end
    end

    describe '.form_fields' do
      it 'double client#form_fields should receive the same arguments' do
        expect(@client).to receive(:form_fields).with('2178204')

        FormStalker.form_fields('2178204')
      end
    end

    describe '.config' do
      it 'double client#config should receive the same arguments' do
        expect(@config).to receive(:oauth_token=).with('123')

        FormStalker.config.oauth_token = '123'
      end
    end
  end
end
