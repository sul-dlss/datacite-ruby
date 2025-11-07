# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/module/delegation'

module Datacite
  module Validators
    # Validate a Cocina object using the attributes validator
    class CocinaValidator
      attr_reader :attributes

      delegate :valid?, :errors, to: :validator

      # @param [Cocina::Models::DRO] cocina_object a Cocina object with descriptive metadata
      def initialize(cocina_object:)
        @attributes = Datacite::Mapping::FromCocina::Attributes.build(cocina_object:)
      end

      private

      def validator
        @validator ||= AttributesValidator.new(attributes:)
      end
    end
  end
end
