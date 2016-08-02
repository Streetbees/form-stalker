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

      it '@response.data should have data' do
        expect(@response.data).to be_an_instance_of FormStalker::Data::Form
        expect(@response.data.created).to be_kind_of(DateTime)
        expect(@response.data.submissions).to be_kind_of(Fixnum)
        expect(@response.data.deleted).to be false
        expect(@response.data.fields.first).to \
          be_an_instance_of FormStalker::Data::FormField
      end

      it '@response.data.logic should have logic_field_ids' do
        expect(@response.data.logic.logic_field_ids).to \
          eq [37_314_745, 41_111_633, 37_314_736, 37_314_784]
      end

      it '@response.data.logic should have calc_field_ids' do
        expect(@response.data.logic.calc_field_ids).to eq []
      end

      it '@response.data.logic should have checks' do
        expect(@response.data.logic.checks).to eq [
          {
            target: 37314714,
            action: 'Show',
            bool: 'AND',
            fields: [41111633],
            checks: [{ field: 41111633, condition: '==', option: 'Option1' }]
          },
          {
            target: 44337087,
            action: 'Show',
            bool: 'AND',
            fields: [37314784],
            checks: [{ field: 37314784, condition: '==', option: '0' }]
          },
          {
            target: 37314734,
            action: 'Show',
            bool: 'AND',
            fields: [37314784],
            checks: [{ field: 37314784, condition: '==', option: '0' }]
          },
          {
            target: 40952921,
            action: 'Show',
            bool: 'AND',
            fields: [37314736],
            checks: [{ field: 37314736, condition: '!=', option: 'Option1' }]
          },
          {
            target: 37314733,
            action: 'Show',
            bool: 'AND',
            fields: [37314736],
            checks: [{ field: 37314736, condition: '==', option: 'Option3' }]
          },
          {
            target: 41111634,
            action: 'Show',
            bool: 'AND',
            fields: [41111633],
            checks: [{ field: 41111633, condition: '==', option: 'Option1' }]
          },
          {
            target: 37314784,
            action: 'Show',
            bool: 'AND',
            fields: [37314745],
            checks: [{ field: 37314745, condition: '==', option: '0' }]
          }
        ]
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
