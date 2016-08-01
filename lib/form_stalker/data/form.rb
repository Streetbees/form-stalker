require 'form_stalker/data/base'

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

      def parse_fields(fields_array)
        (fields_array || []).map { |fields| FormField.new(fields) }
      end
    end
  end
end
