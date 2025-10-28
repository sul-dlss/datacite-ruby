# frozen_string_literal: true

RSpec.describe Datacite::Mapping::FromCocina::ContributorAttributes do
  subject(:contributor_attributes) { described_class.build(description:) }

  let(:description) do
    Cocina::Models::Description.new({
                                      title: [{ value: 'Sample Title' }],
                                      purl: 'https://purl.stanford.edu/xy123z4567',
                                      contributor:
                                    })
  end

  describe '#build' do
    context 'with a publisher contributor' do
      let(:contributor) do
        [
          {
            name: [
              {
                value: 'Stanford, Jane'
              }
            ],
            type: 'organization',
            role: [
              {
                value: 'publisher',
                code: 'pbl',
                uri: 'http://id.loc.gov/vocabulary/relators/pbl',
                source: {
                  code: 'marcrelator',
                  uri: 'http://id.loc.gov/vocabulary/relators/'
                }
              }
            ]
          }
        ]
      end
      let(:datacite_contributors) do
        [{ nameType: 'Organizational', name: 'Stanford, Jane', contributorType: 'Distributor' }]
      end

      it 'maps the datacite contributor' do
        expect(contributor_attributes[:contributors]).to eq(datacite_contributors)
      end
    end

    context 'with an thesis advisor contributors' do
      let(:contributor) do
        [
          {
            name: [
              {
                value: 'Stanford, Jane'
              }
            ],
            type: 'person',
            role: [
              {
                value: 'degree committee member',
                code: 'ths',
                uri: 'http://id.loc.gov/vocabulary/relators/ths',
                source: {
                  code: 'marcrelator',
                  uri: 'http://id.loc.gov/vocabulary/relators/'
                }
              }
            ]
          },
          {
            name: [
              {
                structuredValue: [
                  {
                    value: 'Stanford, John',
                    type: 'name'
                  }
                ]
              }
            ],
            type: 'person',
            role: [
              {
                value: 'degree committee member',
                code: 'ths',
                uri: 'http://id.loc.gov/vocabulary/relators/ths',
                source: {
                  code: 'marcrelator',
                  uri: 'http://id.loc.gov/vocabulary/relators/'
                }
              }
            ]
          }
        ]
      end
      let(:datacite_contributors) do
        [
          { nameType: 'Personal', name: 'Stanford, Jane', contributorType: 'Other' },
          { nameType: 'Personal', name: 'Stanford, John', contributorType: 'Other' }
        ]
      end

      it 'maps the datacite contributor' do
        expect(contributor_attributes[:contributors]).to eq(datacite_contributors)
      end
    end
  end
end
