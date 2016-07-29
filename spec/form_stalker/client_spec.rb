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

  describe '.form' do
    before(:all) do
      @client ||= described_class.new(oauth_token: valid_oauth_token)
    end

    context 'when sending a valid id' do
      before do
        VCR.use_cassette('form_valid_id') do
          @response = @client.form('2178204')
        end
      end

      it '@response should have data' do
        expect(@response.data).to be_an_instance_of FormStalker::Data::Form
      end

      it '@response should NOT have an error' do
        expect(@response.error).to be_nil
      end
    end

    context 'when sending an invalid id' do
      before do
        VCR.use_cassette('form_invalid_id') do
          @response = @client.form(-1)
        end
      end

      it '@response should have an error' do
        expect(@response.error).to eq 'The form was not found'
      end
    end
  end

  describe '.form_fields' do
    before(:all) do
      @client ||= described_class.new(oauth_token: valid_oauth_token)
    end

    context 'when sending a valid id' do
      before do
        VCR.use_cassette('form_fields_valid_id') do
          @response = @client.form_fields('2178204')
        end
      end

      it '@response should have data' do
        expect(@response.data[0]).to \
          be_an_instance_of FormStalker::Data::FormField
      end

      it '@response should NOT have an error' do
        expect(@response.error).to be_nil
      end
    end

    context 'when sending an invalid id' do
      before do
        VCR.use_cassette('form_fields_invalid_id') do
          @response = @client.form_fields(-1)
        end
      end

      it '@response should have an error' do
        expect(@response.error).to eq 'A valid form id was not supplied'
      end
    end
  end
end
