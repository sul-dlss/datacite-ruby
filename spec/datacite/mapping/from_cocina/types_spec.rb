# frozen_string_literal: true

RSpec.describe Datacite::Mapping::FromCocina::Types do
  subject(:types) { described_class.build(description:) }

  let(:description) do
    Cocina::Models::Description.new({
                                      title: [{ value: 'Sample Title' }],
                                      purl: 'https://purl.stanford.edu/xy123z4567',
                                      form:
                                    })
  end

  describe '#build' do
    let(:form) do
      [
        {
          type: 'resource type',
          source: {
            value: 'Stanford self-deposit resource types'
          },
          structuredValue: [
            {
              value: 'dataset metadata',
              type: 'subtype'
            }
          ]
        }
      ]
    end

    it 'maps the datacite subject' do
      expect(types).to eq({ resourceType: 'dataset metadata', resourceTypeGeneral: nil })
    end
  end
end
