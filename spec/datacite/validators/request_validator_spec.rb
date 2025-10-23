# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Datacite::Validators::RequestValidator do
  let(:validate) { described_class.validate(props) }
  let(:props) { Datacite::Mapping::FromCocina::Request.build(cocina_object:) }

  context 'with a fully described object' do
    let(:cocina_object) do
      Cocina::Models::DRO.new(externalIdentifier: druid,
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
                                        value: 'Publisher',
                                        source: {
                                          value: 'H2 contributor role terms'
                                        }
                                      },
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
                                        value: 'Justin Stanford'
                                      }
                                    ],
                                    type: 'person',
                                    role: [
                                      {
                                        value: 'degree committee member'
                                      },
                                      {
                                        value: 'thesis advisor',
                                        code: 'ths',
                                        uri: 'http://id.loc.gov/vocabulary/relators/ths',
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
                                            value: 'John Stanford',
                                            type: 'name'
                                          }
                                        ]
                                      }
                                    ],
                                    type: 'person',
                                    role: [
                                      {
                                        value: 'Editor',
                                        source: {
                                          value: 'H2 contributor role terms'
                                        }
                                      },
                                      {
                                        value: 'editor',
                                        code: 'edt',
                                        uri: 'http://id.loc.gov/vocabulary/relators/edt',
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
                                      type: 'publication',
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
                                  self_deposit_type
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
                                    title: [{
                                      value: 'A random related work title'
                                    }]
                                  },
                                  {
                                    access: {
                                      url: [
                                        {
                                          value: 'https://doi.org/10.1234/example.doi'
                                        }
                                      ]
                                    }
                                  },
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
                                  },
                                  {
                                    type: 'referenced by',
                                    dataCiteRelationType: 'IsReferencedBy',
                                    identifier: [
                                      {
                                        type: 'arxiv',
                                        uri: 'https://arxiv.org/10.1234'
                                      }
                                    ]
                                  },
                                  {
                                    type: 'referenced by',
                                    dataCiteRelationType: 'IsReferencedBy',
                                    identifier: [
                                      {
                                        type: 'pmid',
                                        uri: 'https://pmid.org/10.1234'
                                      }
                                    ]
                                  },
                                  {} # Blank will be removed.
                                ],
                                subject: dro_subject,
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
                              structural: {})
    end
    let(:druid) { 'druid:bb666bb1234' }
    let(:doi) { "10.25740/#{druid.split(':').last}" }
    let(:purl) { "https://purl.stanford.edu/#{druid.split(':').last}" }
    let(:label) { 'label' }
    let(:title) { 'title' }
    let(:apo_druid) { 'druid:pp000pp0000' }
    let(:url) { nil }
    let(:access) { { license: 'https://creativecommons.org/publicdomain/mark/1.0/' } }
    let(:self_deposit_type) { {} }
    let(:dro_subject) do
      [
        {
          value: 'Marine biology',
          type: 'topic',
          uri: 'http://id.worldcat.org/fast/1009447',
          source: {
            code: 'fast',
            uri: 'http://id.worldcat.org/fast/'
          }
        }
      ]
    end

    let(:clazz) { Cocina::Models::DRO }

    it 'does not raise' do
      expect { validate }.not_to raise_error
    end

    context 'when an embargoed item' do
      let(:embargo) { Cocina::Models::Embargo.new(releaseDate: '2026-10-23T07:00:00Z', view: 'world') }
      let(:access) { { embargo: } }

      it 'does not raise' do
        expect { validate }.not_to raise_error
      end
    end

    context 'when subject is not a fast subject' do
      let(:dro_subject) do
        [
          {
            value: 'Marine biology',
            type: 'topic'
          }
        ]
      end

      it 'does not raise' do
        expect { validate }.not_to raise_error
      end
    end

    context 'with a self deposit form type' do
      let(:self_deposit_type) do
        {
          type: 'resource type',
          source: {
            value: 'Stanford self-deposit resource types'
          },
          structuredValue: [
            {
              value: 'extra dataset metadata',
              type: 'type'
            }
          ]
        }
      end

      it 'does not raise' do
        expect { validate }.not_to raise_error
      end
    end

    context 'with a self deposit form subtype' do
      let(:self_deposit_type) do
        {
          type: 'resource type',
          source: {
            value: 'Stanford self-deposit resource types'
          },
          structuredValue: [
            {
              value: 'subset dataset metadata',
              type: 'subtype'
            }
          ]
        }
      end

      it 'does not raise' do
        expect { validate }.not_to raise_error
      end
    end
  end

  context 'with a minimal object' do
    let(:cocina_object) { build(:dro) }

    it 'raises a validation error' do
      expect do
        validate
      end.to raise_error(Datacite::ValidationError)
        .with_message('#/components/schemas/Identifier/properties/identifier does not allow null values')
    end
  end
end
