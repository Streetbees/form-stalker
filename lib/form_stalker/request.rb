require 'net/http'
require 'form_stalker/response'

module FormStalker
  class Request
    attr_reader :response, :connection

    def initialize(connection)
      @connection = connection
    end

    def get(path)
      make_the_call(:get, path)
    end

    protected ######################## PROTECTED ###############################

    def make_the_call(http_verb, path)
      uri = URI(connection.build_url(path))

      http_response = Net::HTTP.send("#{http_verb}_response", uri)

      @response = Response.new(http_response)
    end
  end
end
