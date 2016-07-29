module Helpers
  def valid_oauth_token
    ENV['FORMSTACK_OAUTH_TOKEN'] || 'valid_oauth_token'
  end

  def invalid_oauth_token
    'invalid_oauth_token'
  end
end
