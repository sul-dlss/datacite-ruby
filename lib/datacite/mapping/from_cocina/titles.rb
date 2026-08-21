# frozen_string_literal: true

module Datacite
  module Mapping
    module FromCocina
      # Transform the Cocina::Models::Description title attributes to attributes for one DataCite title
      #  see https://support.datacite.org/reference/dois-2#put_dois-id
      class Titles
        # @param [Cocina::Models::Description] description
        # @return [Array<Hash>] list of titles for DataCite, conforming to the expectations of HTTP PUT request
        # to DataCite
        def self.build(...)
          new(...).call
        end

        def initialize(title:)
          @title = title
        end

        # @return [Array<Hash>] list of titles for DataCite, conforming to the expectations of HTTP PUT request
        # to DataCite
        def call
          [{ title: }]
        end

        private

        attr_reader :title
      end
    end
  end
end
