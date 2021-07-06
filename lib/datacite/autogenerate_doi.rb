# frozen_string_literal: true

module Datacite
  # The JSON request to create a DOI
  class AutogenerateDoi
    # @param [Prefix] prefix
    def initialize(prefix:)
      @prefix = prefix
    end

    # @returns [Hash]
    def to_json(*_args)
      {
        data: {
          type: "dois",
          attributes: {
            prefix: prefix
          }
        }
      }
    end

    private

    attr_reader :prefix
  end
end
