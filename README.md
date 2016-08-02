# FormStalker
FormStack API client that can extract conditional logic.

Some missing methods like editing or deleting a form will be added along the way but we also encourage you do implement them and submitting a PR :thumbsup:

[![Code Climate](https://codeclimate.com/github/Streetbees/form-stalker/badges/gpa.svg)](https://codeclimate.com/github/Streetbees/form-stalker)
[![Test Coverage](https://codeclimate.com/github/Streetbees/form-stalker/badges/coverage.svg)](https://codeclimate.com/github/Streetbees/form-stalker/coverage)
[![Build Status](https://travis-ci.org/Streetbees/form-stalker.svg?branch=master)](https://travis-ci.org/Streetbees/form-stalker)
[![Gem Version](https://badge.fury.io/rb/form_stalker.svg)](https://badge.fury.io/rb/form_stalker)

## 1) Usage
Create an initializer and set your formstack oauth token.
```ruby
FormStalker.configure do |config|
  config.oauth_token = 'your formstack oauth token'
end
```

Make requests to FormStack and receive a sanitized response
```ruby
response = FormStalker.form(1)

# don't trust (response.status == :ok) because Formstack API does not respect the HTTP error status
if response.ok?
  form_data = response.data # returns a FormStalker::Data::Form instance
else
  response.status # returns a symbol representing FormStack's HTTP status
  response.error # returns a message string explaining the error
end
```

Now that you have a **FormStalker::Data::Form** instance, you can access its fields. For example:
```ruby
form_data.id # returns an integer
form_data.created # returns a date
form_data.deleted # returns a boolean
form_data.fields # returns an array of FormStalker::Data::FormField instances

# and the one your are probably looking for
form_data.logic # returns an instance of FormStalker::Data::FormFieldsLogic

form_data.logic.logic_field_ids # returns an array of field ids that have logic
form_data.logic.calc_field_ids # returns an array of field ids

form_data.logic.checks # returns an array of Hashes with the actual logic

# Example of what can be inside the #checks
[
  {
    target: 37314714,
    action: 'Show',
    bool: 'AND',
    fields: [41111633],
    checks: [{ field: 41111633, condition: '==', option: 'Option1' }]
  },
  {
    target: 40952921,
    action: 'Show',
    bool: 'AND',
    fields: [37314736],
    checks: [{ field: 37314736, condition: '!=', option: 'Option1' }]
  }
  {
    target: 37314784,
    action: 'Show',
    bool: 'AND',
    fields: [37314745],
    checks: [{ field: 37314745, condition: '==', option: '0' }]
  }
]
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
- wip
