require 'spec_helper'

describe FormStalker::Client do
  describe '.form' do
    before(:all) do
      @client ||= described_class.new(oauth_token: valid_oauth_token)
    end

    context 'when sending form id 2358865' do
      before do
        VCR.use_cassette('form_2358865') do
          @response = @client.form('2358865')
        end
      end

      it '@response.data should have data' do
        expect(@response.data).to be_an_instance_of FormStalker::Data::Form
      end
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
            target: 37_314_714,
            action: 'Show',
            bool: 'AND',
            fields: [41_111_633],
            checks: [{ field: 41_111_633, condition: '==', option: 'Option1' }]
          },
          {
            target: 44_337_087,
            action: 'Show',
            bool: 'AND',
            fields: [37_314_784],
            checks: [{ field: 37_314_784, condition: '==', option: '0' }]
          },
          {
            target: 37_314_734,
            action: 'Show',
            bool: 'AND',
            fields: [37_314_784],
            checks: [{ field: 37_314_784, condition: '==', option: '0' }]
          },
          {
            target: 40_952_921,
            action: 'Show',
            bool: 'AND',
            fields: [37_314_736],
            checks: [{ field: 37_314_736, condition: '!=', option: 'Option1' }]
          },
          {
            target: 37_314_733,
            action: 'Show',
            bool: 'AND',
            fields: [37_314_736],
            checks: [{ field: 37_314_736, condition: '==', option: 'Option3' }]
          },
          {
            target: 41_111_634,
            action: 'Show',
            bool: 'AND',
            fields: [41_111_633],
            checks: [{ field: 41_111_633, condition: '==', option: 'Option1' }]
          },
          {
            target: 37_314_784,
            action: 'Show',
            bool: 'AND',
            fields: [37_314_745],
            checks: [{ field: 37_314_745, condition: '==', option: '0' }]
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
