# frozen_string_literal: true

require 'json_schemer'
require 'pathname'

module Datacite
  module Validators
    # Perform validation against openapi definition for the DataCite API
    class RequestValidator
      def self.validate(attributes)
        json_attributes = JSON.parse(attributes.to_json)
        schemer = JSONSchemer.schema(json_schema_path)
        results = schemer.validate(json_attributes)
        return true if results.first.nil?

        raise ValidationError, results.map { |result| result.fetch('error') }.join('\n')
      end

      def self.json_schema_path
        Pathname.new(File.expand_path('../../../datacite-v4.5.json', __dir__))
      end
      private_class_method :json_schema_path
    end
  end
end
