lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'form_stalker/version'

Gem::Specification.new do |gem|
  gem.name = 'form_stalker'
  gem.version = FormStalker::VERSION
  gem.license = 'MIT'
  gem.authors = ['StreetBees Dev Team']
  gem.email = 'dev@streetbees.com'
  gem.summary = 'FormStack API client that can extract conditional logic'
  gem.description = 'Ruby FormStack API gem that can extract conditional logic'
  gem.homepage = 'https://github.com/streetbees/form-stalker'

  gem.files = `git ls-files`.split($/)
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'vcr', '3.0.3'
  gem.add_development_dependency 'pry', '0.10.3'
  gem.add_development_dependency 'rake', '11.2.2'
  gem.add_development_dependency 'rspec', '3.4.0'
  gem.add_development_dependency 'webmock', '2.1.0'
  gem.add_development_dependency 'rubocop', '0.37.2'
  gem.add_development_dependency 'simplecov', '0.11.2'
  gem.add_development_dependency 'codeclimate-test-reporter', '0.4.8'
end
