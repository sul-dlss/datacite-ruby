# frozen_string_literal: true

require 'json_schemer'
require 'pathname'

module Datacite
  module Validators
    # Validate a hash of attributes against the DataCite schema
    class AttributesValidator
      # @param [Hash] attributes for a DataCite API request
      def initialize(attributes:)
        @attributes = attributes
      end

      # @return [Boolean] true if valid, false if not
      def valid?
        results.none? # If there are no results (an Enumerator), there were no errors, thus valid
      end

      def errors
        results.map { |result| result.fetch('error') }
      end

      private

      attr_reader :attributes

      def results
        @results ||= schema.validate(attributes)
      end

      def schema
        @schema ||= JSONSchemer.schema(schema_path)
      end

      # This schema file was borrowed from https://github.com/inveniosoftware/datacite/blob/master/datacite/schemas/datacite-v4.5.json
      # and adapted to add the `identifiers` block to comply with v4.6 of the schema.
      def schema_path
        Pathname.new(File.expand_path('../schema/datacite-v4.6.json', __dir__))
      end
    end
  end
end
