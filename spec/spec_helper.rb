require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

require 'simplecov'

SimpleCov.start do
  root('lib/')
  coverage_dir('../tmp/coverage/')
end

$LOAD_PATH << File.expand_path('../', File.dirname(__FILE__))

require 'pry'
require 'vcr'
require 'form_stalker'
require 'webmock/rspec'

Dir['./spec/**/support/**/*.rb'].each do |file|
  require file
end

VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
end

RSpec.configure do |config|
  config.include Helpers

  config.run_all_when_everything_filtered = true

  config.order = 'random'
end
