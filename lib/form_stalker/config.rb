module FormStalker
  class Config
    DEFAULT_VALUES = {
      protocol: 'https',
      base_uri: 'www.formstack.com/api/v2'
    }.freeze

    attr_accessor :protocol, :base_uri, :oauth_token

    def initialize(attributes = nil)
      DEFAULT_VALUES.merge(attributes || {}).each do |name, value|
        send("#{name}=", value)
      end
    end
  end
end
