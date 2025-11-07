[![Gem Version](https://badge.fury.io/rb/datacite.svg)](https://badge.fury.io/rb/datacite)
[![CircleCI](https://circleci.com/gh/sul-dlss/datacite-ruby.svg?style=svg)](https://circleci.com/gh/sul-dlss/datacite-ruby)
[![codecov](https://codecov.io/github/sul-dlss/datacite-ruby/graph/badge.svg?token=1FGARREHJN)](https://codecov.io/github/sul-dlss/datacite-ruby)

# Datacite Ruby Client

This is a Ruby client for interfacing with the DataCite REST API. https://support.datacite.org/docs/api

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'datacite'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install datacite

## Usage

### Initialize the client
```ruby
client = Datacite::Client.new(username: "foo",
                              password: "bar",
                              host: "api.test.datacite.org")
```

### Create a Draft DOI

```ruby
result = client.register_doi(prefix: '10.0001', suffix: 'bc123df4567')

result.either(
  -> response { response },
  -> response { raise("Something went wrong", response.status) }
)
```

#### Auto-generated DOI's

```ruby
result = client.autogenerate_doi(prefix: '10.0001')

result.either(
  -> response { response.doi },
  -> response { raise("Something went wrong", response.status) }
)
```

### Update DOI's

```ruby
# See https://support.datacite.org/reference/dois-2#put_dois-id for the attributes
attributes = {
  relatedIdentifiers: [
    {
      relatedIdentifier: "https://doi.org/10.xxxx/xxxxx",
      relatedIdentifierType: "DOI",
      relationType: "References",
      resourceTypeGeneral: "Dataset"
    }
  ]
}
result = client.update(id: '10.0001/bc123df4567', attributes: attributes)

result.either(
  -> response { response.doi },
  -> response { raise("Something went wrong", response.status) }
)
```

### Determine if a DOI exists

```ruby
result = client.exists?(id: '10.0001/bc123df4567')

result.either(
  -> response { response },
  -> response { raise("Something went wrong", response.status) }
)
```

### Get metadata for a DOI

```ruby
result = client.metadata(id: '10.0001/bc123df4567')

result.either(
  -> response { response },
  -> response { raise("Something went wrong", response.status) }
)
```

## Working with Cocina

### Validating

This gem provides a method for mapping and validating a `Cocina::Models::DRO` object to a DataCite request based on the DataCite JSON Schema (v4.6), without sending any data to the DataCite API:

```ruby
cocina_object = Cocina::Models::DRO.new(...)
validator = Datacite::Validators::CocinaValidator.new(cocina_object:)
puts validator.errors.join(', ') unless validator.valid?
```

NOTE: A Datacite request payload can be validated without first translating from Cocina if you build the request manually or use your own metadata mapping library, e.g.:

```ruby
datacite_attributes = { ... }
validator = Datacite::Validators::AttributesValidator.new(attributes: datacite_attributes)
puts validator.errors.join(', ') unless validator.valid?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sul-dlss/datacite-ruby.
