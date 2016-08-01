require 'form_stalker/data/base'

module FormStalker
  module Data
    class FormField < Base
      schema sort: :integer,
             uniq: :boolean,
             hidden: :boolean,
             colspan: :integer,
             required: :boolean,
             readonly: :boolean,
             hide_label: :boolean,
             option_other: :boolean,
             description_callout: :boolean
    end
  end
end
