# frozen_string_literal: true

require 'active_support/all'
require 'cocina/models'

module Datacite
  module Mapping
    module FromCocina
      # Transform the Cocina::Models::DRO to a DataCite request attributes payload
      class Attributes
        # @param [Cocina::Models::DRO] cocina_object
        # @return [Hash] Hash of DataCite attributes, conforming to the DataCite API Schema
        # @raise [Datacite::ValidationError] if the attributes do no validate to the DataCite schema
        def self.build(...)
          new(...).call
        end

        def initialize(cocina_object:)
          @cocina_object = cocina_object

          # Set the time zone
          Time.zone = 'Pacific Time (US & Canada)'
        end

        attr_reader :cocina_object

        delegate :access, :description, :identification, to: :cocina_object

        def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          attributes = {
            event: 'publish',
            url: description.purl,
            identifiers: Identifiers.build(identification:),
            titles: Titles.build(description:),
            publisher: { name: 'Stanford Digital Repository' }, # per DataCite schema
            publicationYear: publication_year,
            subjects: Subject.build(description:),
            dates: Date.build(cocina_object:),
            language: 'en',
            types: Types.build(description:),
            alternateIdentifiers: AlternateIdentifiers.build(description:),
            relatedIdentifiers: related_identifiers,
            rightsList: RightsList.build(access:),
            descriptions: Descriptions.build(description:),
            relatedItems: related_items,
            schemaVersion: 'http://datacite.org/schema/kernel-4'
          }.merge(ContributorAttributes.build(description:)).compact

          attributes if Datacite::Validators::AttributesValidator.validate(attributes)
        end

        private

        def publication_year
          date = if access.embargo
                   access.embargo.releaseDate.to_datetime
                 else
                   Time.zone.today
                 end
          date.year.to_s
        end

        def related_identifiers
          Array(description&.relatedResource).filter_map do |related_resource|
            RelatedResource.related_identifier_attributes(related_resource:)
          end
        end

        def related_items
          Array(description&.relatedResource).filter_map do |related_resource|
            RelatedResource.related_item_attributes(related_resource:)
          end
        end
      end
    end
  end
end
