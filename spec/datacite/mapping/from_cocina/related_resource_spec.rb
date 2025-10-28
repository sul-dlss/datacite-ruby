# frozen_string_literal: true

RSpec.describe Datacite::Mapping::FromCocina::RelatedResource do
  describe '.related_item_attributes' do
    subject(:related_item) { described_class.related_item_attributes(related_resource:) }

    let(:related_resource) { Cocina::Models::RelatedResource.new(resource) }

    context 'with a doi related resource' do
      let(:resource) do
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
      end
      let(:result) do
        {
          relatedItemType: 'Other',
          titles: [
            title: 'https://doi.org/10.1234/example.doi'
          ],
          relationType: 'IsReferencedBy',
          relatedItemIdentifier: {
            relatedItemIdentifier: 'https://doi.org/10.1234/example.doi',
            relatedItemIdentifierType: 'DOI'
          }
        }
      end

      it 'maps to a DataCite DOI related item' do
        expect(related_item).to eq(result)
      end
    end

    context 'with an arxiv related resource' do
      let(:resource) do
        {
          type: 'referenced by',
          dataCiteRelationType: 'IsReferencedBy',
          identifier: [
            {
              type: 'arxiv',
              uri: 'https://arxiv.org/abs/1234.5678'
            }
          ]
        }
      end
      let(:result) do
        {
          relatedItemType: 'Other',
          titles: [
            title: 'https://arxiv.org/abs/1234.5678'
          ],
          relationType: 'IsReferencedBy',
          relatedItemIdentifier: {
            relatedItemIdentifier: 'https://arxiv.org/abs/1234.5678',
            relatedItemIdentifierType: 'arXiv'
          }
        }
      end

      it 'maps to a DataCite ARXIV related item' do
        expect(related_item).to eq(result)
      end
    end

    context 'with an pmid related resource' do
      let(:resource) do
        {
          type: 'referenced by',
          dataCiteRelationType: 'IsReferencedBy',
          identifier: [
            {
              type: 'pmid',
              uri: 'https://www.ncbi.nlm.nih.gov/pubmed/12345678'
            }
          ]
        }
      end
      let(:result) do
        {
          relatedItemType: 'Other',
          titles: [
            title: 'https://www.ncbi.nlm.nih.gov/pubmed/12345678'
          ],
          relationType: 'IsReferencedBy',
          relatedItemIdentifier: {
            relatedItemIdentifier: 'https://www.ncbi.nlm.nih.gov/pubmed/12345678',
            relatedItemIdentifierType: 'PMID'
          }
        }
      end

      it 'maps to a DataCite PMID related item' do
        expect(related_item).to eq(result)
      end
    end

    context 'with an url based related resource' do
      let(:resource) do
        {
          type: 'referenced by',
          dataCiteRelationType: 'IsReferencedBy',
          access: {
            url: [{
              value: 'https://example.come/some/resource'
            }]
          },
          title: [{
            value: 'Some Resource Title'
          }]
        }
      end
      let(:result) do
        {
          relatedItemType: 'Other',
          titles: [
            title: 'Some Resource Title'
          ],
          relationType: 'IsReferencedBy',
          relatedItemIdentifier: {
            relatedItemIdentifier: 'https://example.come/some/resource',
            relatedItemIdentifierType: 'URL'
          }
        }
      end

      it 'maps to a DataCite URL related item' do
        expect(related_item).to eq(result)
      end
    end
  end
end
