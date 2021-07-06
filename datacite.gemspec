# frozen_string_literal: true

require_relative "lib/datacite/version"

Gem::Specification.new do |spec|
  spec.name          = "datacite"
  spec.version       = Datacite::VERSION
  spec.authors       = ["Justin Coyne"]
  spec.email         = ["jcoyne@justincoyne.com"]

  spec.summary       = "A Ruby client library for the DataCite REST API "
  spec.description   = "See https://support.datacite.org/docs/api"
  spec.homepage      = "https://github.com/sul-dlss/datacite-ruby"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 6.1"
  spec.add_dependency "dry-monads", "~> 1.3"
  spec.add_dependency "faraday", "~> 1.4"
  spec.add_dependency "zeitwerk", "~> 2.4"
end
