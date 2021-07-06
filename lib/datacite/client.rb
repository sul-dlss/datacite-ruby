# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "active_support"
require "dry/monads"

module Datacite
  # The connection to DataCite API
  class Client
    include Dry::Monads[:result]

    def initialize(username:, password:, host: "api.test.datacite.org")
      @conn = Faraday.new(
        url: "https://#{host}",
        headers: headers
      ) do |conn|
        conn.request :json
        conn.basic_auth(username, password)
        conn.response :json
      end
    end

    # @returns [Dry::Monads::Result]
    def autogenerate_doi
      response = conn.post("/dois", autogenerate_doi_json)
      response.success? ? Success(Response.new(response)) : Failure(response)
    end

    private

    def headers
      {
        "Content-Type" => "application/vnd.api+json",
        "User-Agent" => "Datacite Ruby client version #{Datacite::VERSION}"
      }
    end

    def autogenerate_doi_json
      {
        data: {
          type: "dois",
          attributes: {
            prefix: "10.5438"
          }
        }
      }
    end

    attr_reader :conn
  end
end
