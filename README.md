# Datacite Ruby Client

[![Gem Version](https://badge.fury.io/rb/datacite.svg)](https://badge.fury.io/rb/datacite)

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
  -> response { response.doi },
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sul-dlss/datacite-ruby.
