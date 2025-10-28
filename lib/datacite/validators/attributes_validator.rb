# frozen_string_literal: true

require 'json_schemer'
require 'pathname'

module Datacite
  module Validators
    # Perform validation against openapi definition for the DataCite API
    class AttributesValidator
      # @param [Hash] attributes for a DataCite API request
      # @return [Boolean] true if valid
      # @raise [Datacite::ValidationError] if the attributes do no validate to the DataCite schema
      def self.validate(attributes)
        schemer = JSONSchemer.schema(json_schema_path)
        results = schemer.validate(attributes)
        # results is an Enumerator, so checking 'none?' to determine if there were no errors
        return true if results.none?

        raise ValidationError, results.map { |result| result.fetch('error') }.join('\n')
      end

      # This json_schema file borrowed from https://github.com/inveniosoftware/datacite/blob/master/datacite/schemas/datacite-v4.5.json
      # with the addition of the `identifiers` block
      def self.json_schema_path
        Pathname.new(File.expand_path('../schema/datacite-v4.6.json', __dir__))
      end
      private_class_method :json_schema_path
    end
  end
end
