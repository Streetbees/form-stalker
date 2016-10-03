require 'form_stalker/data/base'

module FormStalker
  module Data
    class CheckLogic < Base
      schema field: :integer, target: :integer

      def initialize(attributes)
        if attributes.is_a? String
          attributes = Helpers.json_to_hash "{#{js_to_json(attributes)}}"
        end

        super attributes
      end

      def parse_fields(fields)
        fields.map(&:to_i)
      end

      def parse_checks(checks)
        checks.map { |check| CheckLogic.new(check).attributes }
      end

      protected ####################### PROTECTED ##############################
      def js_to_json(js_object)
        json_converted_keys = convert_keys(js_object)

        convert_values(json_converted_keys)
      end

      private ######################### PRIVATE ################################

      def convert_keys(js_object)
        js_object.gsub(/([a-z]+):/, '"\1":')
      end

      def convert_values(js_object)
        js_object.gsub(/'(.*?(?<!\\))'/) do |match|
          value = match
            .gsub(/^'/, '').gsub(/'$/,'')

          "\"#{value}\""
        end
      end

    end
  end
end
