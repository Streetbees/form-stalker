require 'form_stalker/data/base'
require 'form_stalker/data/form_field'
require 'form_stalker/data/form_fields_logic'

module FormStalker
  module Data
    class Form < Base
      schema db: :boolean,
             views: :integer,
             deleted: :boolean,
             created: :datetime,
             updated: :datetime,
             inactive: :boolean,
             encrypted: :boolean,
             submissions: :integer,
             submissions_today: :integer,
             submissions_unread: :integer,
             last_submission_id: :integer,
             last_submission_time: :datetime

      attr_reader :logic

      def parse_html(html)
        @logic = FormFieldsLogic.new(html)

        html
      end

      def parse_fields(fields_array)
        (fields_array || []).map { |fields| FormField.new(fields) }
      end
    end
  end
end
