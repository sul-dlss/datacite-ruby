# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Datacite::Validators::AttributesValidator do
  let(:validator) { described_class.new(attributes:) }
  let(:attributes) do
    {
      event: 'publish',
      url: 'https://purl.stanford.edu/bb666bb1234',
      schemaVersion: 'http://datacite.org/schema/kernel-4',
      identifiers: [
        {
          identifier: '10.25740/bb666bb1234',
          identifierType: 'DOI'
        }
      ],
      titles: [
        {
          title: 'title'
        }
      ],
      publisher: {
        name: 'Stanford Digital Repository'
      },
      publicationYear: '2025',
      types: {
        resourceTypeGeneral: 'Text',
        resourceType: 'Journal Article'
      },
      creators: [
        {
          nameType: 'Personal',
          affiliation: [
            {
              affiliationIdentifier: 'https://ror.org/00f54p054',
              affiliationIdentifierScheme: 'ROR',
              name: 'Stanford University',
              schemeUri: 'https://ror.org/'
            }
          ],
          name: 'Stanford, Jane',
          givenName: 'Jane',
          familyName: 'Stanford'
        }
      ]
    }
  end

  context 'with the minimal required request payload' do
    it 'validates' do
      expect(validator).to be_valid
    end

    context 'when contributors are present' do
      let(:contributors) do
        [
          {
            name: 'National Institute of Health',
            nameType: 'Organizational',
            contributorType: 'Distributor'
          },
          {
            nameType: 'Personal',
            affiliation: [
              {
                affiliationIdentifier: 'https://ror.org/00f54p054',
                affiliationIdentifierScheme: 'ROR',
                name: 'Stanford University',
                schemeUri: 'https://ror.org/'
              }
            ],
            name: 'Justin Stanford',
            contributorType: 'Other'
          }
        ]
      end

      before do
        attributes[:contributors] = contributors
      end

      it 'validates' do
        expect(validator).to be_valid
      end
    end

    context 'when dates are provided' do
      let(:dates) do
        [
          {
            date: '2021-01-01',
            dateType: 'Created'
          },
          {
            date: '2023-12-31',
            dateType: 'Available'
          }
        ]
      end

      before do
        attributes[:dates] = dates
      end

      it 'validates' do
        expect(validator).to be_valid
      end
    end

    context 'when language is provided' do
      before do
        attributes[:language] = 'en'
      end

      it 'validates' do
        expect(validator).to be_valid
      end
    end

    context 'when type is provided' do
      before do
        attributes[:types] = {
          resourceTypeGeneral: 'Text',
          resourceType: 'Journal Article'
        }
      end

      it 'validates' do
        expect(validator).to be_valid
      end
    end
  end

  context 'when required values are missing' do
    let(:attributes) do
      {
        event: 'publish',
        url: 'https://purl.stanford.edu/bb666bb1234',
        schemaVersion: 'http://datacite.org/schema/kernel-4'
      }
    end

    it 'does not validate' do
      expect(validator).not_to be_valid
    end

    it 'returns expected errors' do
      validator.valid?
      expect(validator.errors).to include('object at root is missing required properties: identifiers, creators, ' \
                                          'titles, publisher, publicationYear, types')
    end
  end

  context 'when an invalid value is provided' do
    before do
      attributes[:unkownProperty] = 'this is not valid'
    end

    it 'does not validate' do
      expect(validator).not_to be_valid
    end

    it 'returns expected errors' do
      validator.valid?
      expect(validator.errors).to include('object property at `/unkownProperty` is a disallowed additional property')
    end
  end
end
