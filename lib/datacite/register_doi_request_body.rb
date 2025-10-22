# frozen_string_literal: true

module Datacite
  # The JSON request to create a specific DOI
  class RegisterDoiRequestBody
    # @param [String] prefix
    # @param [String] suffix
    def initialize(prefix:, suffix:)
      @prefix = prefix
      @suffix = suffix
    end

    # @returns [Hash]
    def to_json(*_args)
      {
        data: {
          type: 'dois',
          attributes: {
            doi: "#{prefix}/#{suffix}"
          }
        }
      }
    end

    private

    attr_reader :prefix, :suffix
  end
end
