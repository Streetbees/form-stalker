require 'spec_helper'

describe FormStalker::Client do
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
        expect(@response.data.created).to be_kind_of(DateTime)
        expect(@response.data.submissions).to be_kind_of(Fixnum)
        expect(@response.data.deleted).to be false
        expect(@response.data.fields.first).to \
          be_an_instance_of FormStalker::Data::FormField
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
end
