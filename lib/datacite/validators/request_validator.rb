# frozen_string_literal: true

module Datacite
  module Validators
    # Perform validation against openapi definition for the DataCite API
    class RequestValidator
      def self.validate(attributes)
        request_operation = root.request_operation(:post, '/validate/Request')

        # JSON.parse forces serialization of objects like DateTime.
        json_attributes = JSON.parse(attributes.to_json)

        request_operation.validate_request_body('application/json', json_attributes)
      rescue OpenAPIParser::OpenAPIError => e
        raise ValidationError, e.message
      end

      # rubocop:disable Style/ClassVars
      def self.root
        @@root ||= OpenAPIParser.parse(YAML.load_file(openapi_path), strict_reference_validation: true)
      end
      # rubocop:enable Style/ClassVars
      private_class_method :root

      def self.openapi_path
        ::File.expand_path('../../../openapi.yml', __dir__)
      end
      private_class_method :openapi_path
    end
  end
end
