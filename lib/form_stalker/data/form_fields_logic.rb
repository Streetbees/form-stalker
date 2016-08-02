require 'form_stalker/data/check_logic'
require 'form_stalker/data/base'

module FormStalker
  module Data
    class FormFieldsLogic < Base
      def initialize(html)
        super checks: extract_checks(html),
              calc_field_ids: extract_calc_field_ids(html),
              logic_field_ids: extract_logic_field_ids(html)
      end

      def parse_calc_field_ids(value)
        Helpers.string_to_array_of_integers(value)
      end

      def parse_logic_field_ids(value)
        Helpers.string_to_array_of_integers(value)
      end

      def parse_checks(values)
        values.map { |js_object| CheckLogic.new(js_object).attributes }
      end

      protected ####################### PROTECTED ##############################

      def extract_checks(html)
        Helpers.extract_from_regex(html, /.*checks.push\({(.*)}\)/i)
      end

      def extract_calc_field_ids(html)
        Helpers.extract_from_regex(html, /.*calcFields.*=.*\[(.*)\]/i)[0]
      end

      def extract_logic_field_ids(html)
        Helpers.extract_from_regex(html, /.*logicFields.*=.*\[(.*)\]/i)[0]
      end
    end
  end
end
