# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Datacite::Validators::AttributesValidator do
  let(:validate) { described_class.validate(props) }
  let(:props) do
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
    it 'does not raise' do
      expect { validate }.not_to raise_error
    end

    context 'when contributors are prosent' do
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
        props[:contributors] = contributors
      end

      it 'does not raise' do
        expect { validate }.not_to raise_error
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
        props[:dates] = dates
      end

      it 'does not raise' do
        expect { validate }.not_to raise_error
      end
    end

    context 'when language is provided' do
      before do
        props[:language] = 'en'
      end

      it 'does not raise' do
        expect { validate }.not_to raise_error
      end
    end

    context 'when type is provided' do
      before do
        props[:types] = {
          resourceTypeGeneral: 'Text',
          resourceType: 'Journal Article'
        }
      end

      it 'does not raise' do
        expect { validate }.not_to raise_error
      end
    end
  end

  context 'when required values are missing' do
    before do
      props.except!(:creators, :identifiers, :publicationYear, :publisher, :titles, :types)
    end

    it 'raises a validation error' do
      expect do
        validate
      end.to raise_error(Datacite::ValidationError)
        .with_message('object at root is missing required properties: identifiers, creators, ' \
                      'titles, publisher, publicationYear, types')
    end
  end

  context 'when an invalid value is provided' do
    before do
      props[:unkownProperty] = 'this is not valid'
    end

    it 'raises a validation error' do
      expect do
        validate
      end.to raise_error(Datacite::ValidationError)
        .with_message('object property at `/unkownProperty` is a disallowed additional property')
    end
  end
end
