# FormStalker
FormStack API client that can extract conditional logic.
Some missing methods like editing or deleting a form will be added along the way, but we also encourage you do implement them and submitting a PR :thumbsup:

[![Code Climate](https://codeclimate.com/github/Streetbees/form-stalker/badges/gpa.svg)](https://codeclimate.com/github/Streetbees/form-stalker)
[![Test Coverage](https://codeclimate.com/github/Streetbees/form-stalker/badges/coverage.svg)](https://codeclimate.com/github/Streetbees/form-stalker/coverage)
[![Build Status](https://travis-ci.org/Streetbees/form-stalker.svg?branch=master)](https://travis-ci.org/Streetbees/form-stalker)

## 1) Usage
Create an initializer and set your your formstack oauth token.
```ruby
FormStalker.configure do |config|
  config.oauth_token = 'your formstack oauth token'
end
```

Make requests to FormStack and receive a sanitized response
```ruby
response = FormStalker.form(1)

if response.ok? # or (response.status == :ok)
  form_data = response.data
else
  response.status # will return a symbol representing FormStack's HTTP status
  response.error # will return a message string explaining the error
end
```

## 2) Instalation

Add this to your Gemfile:
```
gem 'form_stalker'
```

And then execute:

```
$> bundle install
```

## 3) F.A.Q.
wip
