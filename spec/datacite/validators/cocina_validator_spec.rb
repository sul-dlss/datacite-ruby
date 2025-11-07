# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Datacite::Validators::CocinaValidator do
  let(:validator) { described_class.new(cocina_object:) }
  let(:cocina_object) do
    Cocina::Models::DRO.new(
      externalIdentifier: druid,
      type: Cocina::Models::ObjectType.object,
      label: label,
      version: 1,
      description: {
        contributor: [
          {
            name: [
              {
                value: 'National Institute of Health'
              }
            ],
            type: 'organization',
            status: 'primary',
            role: [
              {
                value: 'Funder',
                source: {
                  value: 'H2 contributor role terms'
                }
              },
              {
                value: 'funder',
                code: 'fnd',
                uri: 'http://id.loc.gov/vocabulary/relators/fnd',
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
                    value: 'Jane',
                    type: 'forename'
                  },
                  {
                    value: 'Stanford',
                    type: 'surname'
                  }
                ]
              }
            ],
            type: 'person',
            role: [
              {
                value: 'Author',
                source: {
                  value: 'H2 contributor role terms'
                }
              },
              {
                value: 'author',
                code: 'aut',
                uri: 'http://id.loc.gov/vocabulary/relators/aut',
                source: {
                  code: 'marcrelator',
                  uri: 'http://id.loc.gov/vocabulary/relators/'
                }
              }
            ],
            affiliation: [
              {
                structuredValue: [
                  {
                    value: 'Stanford University',
                    identifier: [
                      {
                        uri: 'https://ror.org/00f54p054',
                        type: 'ROR',
                        source: {
                          code: 'ror'
                        }
                      }
                    ]
                  },
                  {
                    value: 'Woods Institute for the Environment'
                  }
                ]
              }
            ],
            note: [
              {
                type: 'citation status',
                value: 'false'
              }
            ]
          },
          {
            name: [
              {
                structuredValue: [
                  {
                    value: 'John',
                    type: 'forename'
                  },
                  {
                    value: 'Stanford',
                    type: 'surname'
                  }
                ]
              }
            ],
            type: 'person',
            role: [
              {
                value: 'Author',
                source: {
                  value: 'H2 contributor role terms'
                }
              },
              {
                value: 'author',
                code: 'aut',
                uri: 'http://id.loc.gov/vocabulary/relators/aut',
                source: {
                  code: 'marcrelator',
                  uri: 'http://id.loc.gov/vocabulary/relators/'
                }
              }
            ],
            affiliation: [
              {
                value: 'Stanford University',
                identifier: [
                  {
                    uri: 'https://ror.org/00f54p054',
                    type: 'ROR',
                    source: {
                      code: 'ror'
                    }
                  }
                ]
              }
            ],
            note: [
              {
                type: 'citation status',
                value: 'false'
              }
            ]
          },
          {
            name: [
              {
                structuredValue: [
                  {
                    value: 'Stanford University',
                    identifier: [
                      {
                        type: 'ROR',
                        uri: 'https://ror.org/00f54p054',
                        source: {
                          code: 'ror'
                        }
                      }
                    ]
                  },
                  {
                    value: 'Department of Animal Husbandry'
                  }
                ]
              }
            ],
            type: 'organization',
            status: 'primary',
            role: [
              {
                value: 'degree granting institution',
                code: 'dgg',
                uri: 'http://id.loc.gov/vocabulary/relators/dgg',
                source: {
                  code: 'marcrelator',
                  uri: 'http://id.loc.gov/vocabulary/relators/'
                }
              }
            ],
            note: [
              {
                type: 'citation status',
                value: 'false'
              }
            ]
          }
        ],
        event: [
          {
            type: 'deposit',
            date: [
              value: '2022-01-01',
              type: 'deposit',
              encoding: {
                code: 'w3cdtf'
              }
            ],
            contributor: [
              {
                name: [
                  {
                    value: 'Stanford Digital Repository'
                  }
                ],
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
                ],
                type: 'organization'
              }
            ]
          }
        ],
        form: [
          {
            value: 'Dataset',
            type: 'resource type',
            uri: 'http://id.loc.gov/vocabulary/resourceTypes/dat',
            source: {
              uri: 'http://id.loc.gov/vocabulary/resourceTypes/'
            }
          },
          {
            value: 'Data sets',
            type: 'genre',
            uri: 'https://id.loc.gov/authorities/genreForms/gf2018026119',
            source: {
              code: 'lcgft'
            }
          },
          {
            value: 'dataset',
            type: 'genre',
            source: {
              code: 'local'
            }
          },
          {
            value: 'Dataset',
            type: 'resource type',
            source: {
              value: 'DataCite resource types'
            }
          },
          {
            type: 'resource type',
            source: {
              value: 'Stanford self-deposit resource types'
            },
            structuredValue: [
              {
                value: 'dataset metadata',
                type: 'type'
              }
            ]
          }
        ],
        identifier: [
          {
            value: doi,
            type: 'DOI'
          }
        ],
        note: [
          {
            type: 'abstract',
            value: 'My paper is about dolphins.'
          }
        ],
        purl: purl,
        relatedResource: [
          {
            note: [
              {
                value: 'Stanford University (Stanford, CA.). (2020). May 2020 dataset. ' \
                       'yadda yadda.',
                type: 'preferred citation'
              }
            ]
          },
          {
            type: 'referenced by',
            dataCiteRelationType: 'IsReferencedBy',
            identifier: [
              {
                type: 'doi',
                uri: 'https://doi.org/10.1234/example.doi'
              }
            ]
          }
        ],
        subject: [
          {
            value: 'Marine biology',
            type: 'topic',
            uri: 'http://id.worldcat.org/fast/1009447',
            source: {
              code: 'fast',
              uri: 'http://id.worldcat.org/fast/'
            }
          },
          {
            value: 'Non Marine biology',
            type: 'topic'
          }
        ],
        title: [{ value: title }]
      },
      identification: {
        sourceId: 'sul:8.559351',
        doi: doi
      },
      access:,
      administrative: {
        hasAdminPolicy: apo_druid
      },
      structural: {}
    )
  end
  let(:druid) { 'druid:bb666bb1234' }
  let(:doi) { "10.25740/#{druid.split(':').last}" }
  let(:purl) { "https://purl.stanford.edu/#{druid.split(':').last}" }
  let(:label) { 'label' }
  let(:title) { 'title' }
  let(:apo_druid) { 'druid:pp000pp0000' }
  let(:access) { { embargo:, license: 'https://creativecommons.org/publicdomain/mark/1.0/' } }
  let(:embargo) { Cocina::Models::Embargo.new(releaseDate: '2026-10-23T07:00:00Z', view: 'world') }

  describe '#attributes' do
    it 'returns a DataCite attributes hash' do
      expect(validator.attributes).to be_a(Hash)
    end
  end

  describe '#valid?' do
    context 'when attributes are valid' do
      it 'returns true' do
        expect(validator).to be_valid
      end
    end

    context 'when attributes are not valid' do
      before do
        allow(validator).to receive(:validator).and_return(
          instance_double(Datacite::Validators::AttributesValidator, valid?: false)
        )
      end

      it 'returns false' do
        expect(validator).not_to be_valid
      end
    end
  end

  describe '#errors' do
    before { validator.valid? }

    context 'when attributes are valid' do
      it 'returns no errors' do
        expect(validator.errors).to be_empty
      end
    end

    context 'when attributes are not valid' do
      before do
        allow(validator).to receive(:validator).and_return(
          instance_double(Datacite::Validators::AttributesValidator, valid?: false, errors: ['stuff is broken'])
        )
      end

      it 'returns errors' do
        expect(validator.errors).to include('stuff is broken')
      end
    end
  end
end
