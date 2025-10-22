# frozen_string_literal: true

module Datacite
  module Mapping
    # Maps description resource from cocina to DataCite JSON
    class Identifiers
      # @param [Cocina::Models::Identification] identification
      def self.build(...)
        new(...).call
      end

      def initialize(identification:)
        @identification = identification
      end

      attr_reader :identification

      def call
        [{
          identifier: identification.doi,
          identifierType: 'DOI'
        }]
      end
    end
  end
end
