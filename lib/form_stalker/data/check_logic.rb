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
        js_object.split(',').map(&:strip).map do |js_string|
          escape_js_to_json(js_string)
        end.join(', ')
      end

      private ######################### PRIVATE ################################

      def escape_js_to_json(js_string)
        string = js_string.tr('"', '\"')
                          .tr("'", '"')
                          .gsub('{', '{"')
                          .gsub(':', '":')

        ['"', '{'].include?(string[0]) ? string : "\"#{string}"
      end
    end
  end
end
