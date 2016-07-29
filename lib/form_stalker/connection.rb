module FormStalker
  class Connection
    attr_reader :config

    def initialize(config_or_options)
      @config = config_or_options

      @config = Config.new(@config) if @config.is_a?(Hash)
    end

    def build_url(path)
      [config.protocol, '://', config.base_uri, '/', path,
       "?oauth_token=#{config.oauth_token}"].join
    end
  end
end
