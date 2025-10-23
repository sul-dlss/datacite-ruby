# frozen_string_literal: true

module Datacite
  module Mapping
    module FromCocina
      # Transform the Cocina::Models::Identification to the DataCite identifier attributes
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
end
