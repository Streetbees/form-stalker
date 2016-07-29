require 'form_stalker/data/base'
require 'form_stalker/data/form'
require 'form_stalker/data/form_field'
require 'form_stalker/connection'
require 'form_stalker/request'

module FormStalker
  class Client
    attr_reader :connection

    def initialize(config_or_options = nil)
      @connection = Connection.new(config_or_options || {})
    end

    def config
      connection.config
    end

    def form(form_id)
      Data::Form.tap_into request.get("form/#{form_id}.json")
    end

    def form_fields(form_id)
      Data::FormField.tap_into request.get("form/#{form_id}/field.json")
    end

    protected ######################## PROTECTED ###############################

    def request
      Request.new(connection)
    end
  end
end
