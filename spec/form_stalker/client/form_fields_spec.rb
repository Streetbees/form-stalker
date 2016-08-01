require 'spec_helper'

describe FormStalker::Client do
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
        first_sample = @response.data[0]

        expect(first_sample).to be_an_instance_of FormStalker::Data::FormField
        expect(first_sample.sort).to be_kind_of(Fixnum)
        expect(first_sample.required).to be true
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
