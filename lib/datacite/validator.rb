# frozen_string_literal: true

require "json_schema"

module Datacite
  # Validates the request data is valid
  class Validator
    def self.validate!(data)
      # Schema from https://github.com/datacite/schema/blob/master/source/json/kernel-4.3/datacite_4.3_schema.json
      # with changes:
      #  1. Remove invalid formats https://github.com/datacite/schema/issues/96
      #  2. Remove required fields https://github.com/datacite/schema/issues/97
      #  3. Added "additionalProperties": false

      schema_data = JSON.parse(File.read("#{__dir__}/schema.json"))
      schema = JsonSchema.parse!(schema_data)
      schema.validate!(data)
    end
  end
end
