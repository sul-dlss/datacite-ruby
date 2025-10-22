# frozen_string_literal: true

module Datacite
  # The response object from the datacite API
  class Response
    # @param [Hash] response a json reponse
    def initialize(response)
      @body = response.body
    end

    attr_reader :body

    def doi
      body.dig('data', 'id')
    end
  end
end
