require 'form_stalker/version'
require 'form_stalker/client'
require 'form_stalker/config'

module FormStalker
  module_function

  def configure
    yield(config)
  end

  def config
    client.config
  end

  def client
    @client ||= Client.new(Config.new)
  end
end
