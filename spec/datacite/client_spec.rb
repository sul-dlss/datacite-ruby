# frozen_string_literal: true

RSpec.describe Datacite::Client do
  subject(:client) { described_class.new(username: "foo", password: "bar") }

  describe "#register_doi" do
    subject(:generate) { client.register_doi(prefix: "10.5438", suffix: "doc-1") }

    context "when the response is successful" do
      before do
        stub_request(:post, "https://api.test.datacite.org/dois")
          .with(
            body: "{\"data\":{\"type\":\"dois\",\"attributes\":{\"doi\":\"10.5438/doc-1\"}}}",
            headers: {
              "Authorization" => "Basic Zm9vOmJhcg==",
              "Content-Type" => "application/vnd.api+json"
            }
          )
          .to_return(status: 200, body: response, headers: { "Content-Type" => "application/json" })
      end

      let(:response) do
        <<~JSON
          {
            "data": {
              "id": "10.5438/doc-1",
              "type": "dois",
              "attributes": {
                "doi": "10.5438/doc-1",
                "prefix": "10.5438",
                "suffix": "0012",
                "identifiers": [{
                  "identifier": "https://doi.org/10.5438/doc-1",
                  "identifierType": "DOI"
                }],
                "creators": [],
                "titles": [],
                "publisher": null,
                "container": {},
                "publicationYear": null,
                "subjects": [],
                "contributors": [],
                "dates": [],
                "language": null,
                "types": {},
                "relatedIdentifiers": [],
                "sizes": [],
                "formats": [],
                "version": null,
                "rightsList": [],
                "descriptions": [],
                "geoLocations": [],
                "fundingReferences": [],
                "xml": null,
                "url":null,
                "contentUrl": null,
                "metadataVersion": 1,
                "schemaVersion": "http://datacite.org/schema/kernel-4",
                "source": null,
                "isActive": true,
                "state": "draft",
                "reason": null,
                "created": "2016-09-19T21:53:56.000Z",
                "registered": null,
                "updated": "2019-02-06T14:31:27.000Z"
              },
              "relationships": {
                "client": {
                  "data": {
                    "id": "datacite.datacite",
                    "type": "clients"
                  }
                },
                "media": {
                  "data": []
                }
              }
            },
            "included": [{
              "id": "datacite.datacite",
              "type": "clients",
              "attributes": {
                "name": "DataCite",
                "symbol": "DATACITE.DATACITE",
                "year": 2011,
                "contactName": "DataCite",
                "contactEmail": "support@datacite.org",
                "description": null,
                "domains": "*",
                "url": null,
                "created": "2011-12-07T13:43:39.000Z",
                "updated": "2019-01-02T17:33:06.000Z",
                "isActive": true,
                "hasPassword": true
              },
              "relationships": {
                "provider": {
                  "data": {
                    "id": "datacite",
                    "type": "providers"
                  }
                },
                "prefixes": {
                  "data": [{
                    "id": "10.5438",
                    "type": "prefixes"
                  }]
                }
              }
            }]
          }
        JSON
      end

      it "can register a DOI" do
        expect(generate).to be_success
        expect(generate.value!.doi).to eq "10.5438/doc-1"
      end
    end

    context "when the response is unsuccessful" do
      before do
        stub_request(:post, "https://api.test.datacite.org/dois")
          .with(
            body: "{\"data\":{\"type\":\"dois\",\"attributes\":{\"doi\":\"10.5438/doc-1\"}}}",
            headers: {
              "Authorization" => "Basic Zm9vOmJhcg==",
              "Content-Type" => "application/vnd.api+json"
            }
          )
          .to_return(status: 404, body: response, headers: { "Content-Type" => "application/json" })
      end

      let(:response) do
        <<~JSON
          {"errors":[{"status": "404","title":"The resource you are looking for doesn't exist."}]}
        JSON
      end

      it "returns a failure" do
        expect(generate).to be_failure
        expect(generate.failure.body).to eq(
          "errors" => [{ "status" => "404", "title" => "The resource you are looking for doesn't exist." }]
        )
      end
    end
  end

  describe "#autogenerate_doi" do
    subject(:generate) { client.autogenerate_doi(prefix: "10.5438") }

    context "when the response is successful" do
      before do
        stub_request(:post, "https://api.test.datacite.org/dois")
          .with(
            body: "{\"data\":{\"type\":\"dois\",\"attributes\":{\"prefix\":\"10.5438\"}}}",
            headers: {
              "Authorization" => "Basic Zm9vOmJhcg==",
              "Content-Type" => "application/vnd.api+json"
            }
          )
          .to_return(status: 200, body: response, headers: { "Content-Type" => "application/json" })
      end

      let(:response) do
        <<~JSON
          {
            "data": {
              "id": "10.5438/0012",
              "type": "dois",
              "attributes": {
                "doi": "10.5438/0012",
                "prefix": "10.5438",
                "suffix": "0012",
                "identifiers": [{
                  "identifier": "https://doi.org/10.5438/0012",
                  "identifierType": "DOI"
                }],
                "creators": [],
                "titles": [],
                "publisher": null,
                "container": {},
                "publicationYear": null,
                "subjects": [],
                "contributors": [],
                "dates": [],
                "language": null,
                "types": {},
                "relatedIdentifiers": [],
                "sizes": [],
                "formats": [],
                "version": null,
                "rightsList": [],
                "descriptions": [],
                "geoLocations": [],
                "fundingReferences": [],
                "xml": null,
                "url":null,
                "contentUrl": null,
                "metadataVersion": 1,
                "schemaVersion": "http://datacite.org/schema/kernel-4",
                "source": null,
                "isActive": true,
                "state": "draft",
                "reason": null,
                "created": "2016-09-19T21:53:56.000Z",
                "registered": null,
                "updated": "2019-02-06T14:31:27.000Z"
              },
              "relationships": {
                "client": {
                  "data": {
                    "id": "datacite.datacite",
                    "type": "clients"
                  }
                },
                "media": {
                  "data": []
                }
              }
            },
            "included": [{
              "id": "datacite.datacite",
              "type": "clients",
              "attributes": {
                "name": "DataCite",
                "symbol": "DATACITE.DATACITE",
                "year": 2011,
                "contactName": "DataCite",
                "contactEmail": "support@datacite.org",
                "description": null,
                "domains": "*",
                "url": null,
                "created": "2011-12-07T13:43:39.000Z",
                "updated": "2019-01-02T17:33:06.000Z",
                "isActive": true,
                "hasPassword": true
              },
              "relationships": {
                "provider": {
                  "data": {
                    "id": "datacite",
                    "type": "providers"
                  }
                },
                "prefixes": {
                  "data": [{
                    "id": "10.5438",
                    "type": "prefixes"
                  }]
                }
              }
            }]
          }
        JSON
      end

      it "can mint a random DOI" do
        expect(generate).to be_success
        expect(generate.value!.doi).to eq "10.5438/0012"
      end
    end

    context "when the response is unsuccessful" do
      before do
        stub_request(:post, "https://api.test.datacite.org/dois")
          .with(
            body: "{\"data\":{\"type\":\"dois\",\"attributes\":{\"prefix\":\"10.5438\"}}}",
            headers: {
              "Authorization" => "Basic Zm9vOmJhcg==",
              "Content-Type" => "application/vnd.api+json"
            }
          )
          .to_return(status: 404, body: response, headers: { "Content-Type" => "application/json" })
      end

      let(:response) do
        <<~JSON
          {"errors":[{"status": "404","title":"The resource you are looking for doesn't exist."}]}
        JSON
      end

      it "returns a failure" do
        expect(generate).to be_failure
        expect(generate.failure.body).to eq(
          "errors" => [{ "status" => "404", "title" => "The resource you are looking for doesn't exist." }]
        )
      end
    end
  end

  describe "#update" do
    subject(:generate) { client.update(id: "10.5438/bc123df4567", attributes: attributes) }

    let(:attributes) do
      {
        "event" => "publish",
        "url" => "https://purl.stanford.edu/st435qh3132",
        "relatedIdentifiers" => [
          {
            "relatedIdentifier" => "https://doi.org/10.xxxx/xxxxx",
            "relatedIdentifierType" => "DOI",
            "relationType" => "References",
            "resourceTypeGeneral" => "Dataset"
          }
        ]
      }
    end
    let(:request_body) do
      <<~JSON
        {"data":{"attributes":{"event":"publish","url":"https://purl.stanford.edu/st435qh3132","relatedIdentifiers":[{"relatedIdentifier":"https://doi.org/10.xxxx/xxxxx","relatedIdentifierType":"DOI","relationType":"References","resourceTypeGeneral":"Dataset"}]}}}
      JSON
    end

    before do
      stub_request(:put, "https://api.test.datacite.org/dois/10.5438/bc123df4567")
        .with(
          body: request_body.chomp,
          headers: {
            "Authorization" => "Basic Zm9vOmJhcg==",
            "Content-Type" => "application/vnd.api+json"
          }
        )
        .to_return(status: status, body: response, headers: { "Content-Type" => "application/json" })
    end

    context "when the request is invalid" do
      let(:attributes) do
        { "foo" => "bar" }
      end

      let(:status) { 200 }
      let(:response) do
        nil
      end

      it "can update the DOI" do
        expect { generate }.to raise_error JsonSchema::AggregateError
      end
    end

    context "when the response is successful" do
      let(:status) { 200 }

      let(:response) do
        <<~JSON
          {
            "data": {
              "id": "10.5438/0012",
              "type": "dois",
              "attributes": {
                "doi": "10.5438/0012",
                "prefix": "10.5438",
                "suffix": "0012",
                "identifiers": [{
                  "identifier": "https://doi.org/10.5438/0012",
                  "identifierType": "DOI"
                }],
                "creators": [],
                "titles": [],
                "publisher": null,
                "container": {},
                "publicationYear": null,
                "subjects": [],
                "contributors": [],
                "dates": [],
                "language": null,
                "types": {},
                "relatedIdentifiers": [],
                "sizes": [],
                "formats": [],
                "version": null,
                "rightsList": [],
                "descriptions": [],
                "geoLocations": [],
                "fundingReferences": [],
                "xml": null,
                "url":null,
                "contentUrl": null,
                "metadataVersion": 1,
                "schemaVersion": "http://datacite.org/schema/kernel-4",
                "source": null,
                "isActive": true,
                "state": "draft",
                "reason": null,
                "created": "2016-09-19T21:53:56.000Z",
                "registered": null,
                "updated": "2019-02-06T14:31:27.000Z"
              },
              "relationships": {
                "client": {
                  "data": {
                    "id": "datacite.datacite",
                    "type": "clients"
                  }
                },
                "media": {
                  "data": []
                }
              }
            },
            "included": [{
              "id": "datacite.datacite",
              "type": "clients",
              "attributes": {
                "name": "DataCite",
                "symbol": "DATACITE.DATACITE",
                "year": 2011,
                "contactName": "DataCite",
                "contactEmail": "support@datacite.org",
                "description": null,
                "domains": "*",
                "url": null,
                "created": "2011-12-07T13:43:39.000Z",
                "updated": "2019-01-02T17:33:06.000Z",
                "isActive": true,
                "hasPassword": true
              },
              "relationships": {
                "provider": {
                  "data": {
                    "id": "datacite",
                    "type": "providers"
                  }
                },
                "prefixes": {
                  "data": [{
                    "id": "10.5438",
                    "type": "prefixes"
                  }]
                }
              }
            }]
          }
        JSON
      end

      it "can update the DOI" do
        expect(generate).to be_success
        expect(generate.value!.doi).to eq "10.5438/0012"
      end
    end

    context "when the response is unsuccessful" do
      let(:status) { 404 }

      let(:response) do
        <<~JSON
          {"errors":[{"status": "404","title":"The resource you are looking for doesn't exist."}]}
        JSON
      end

      it "returns a failure" do
        expect(generate).to be_failure
        expect(generate.failure.body).to eq(
          "errors" => [{ "status" => "404", "title" => "The resource you are looking for doesn't exist." }]
        )
      end
    end

    context "when the request is in xml" do
      let(:xml) do
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" \
          "<resource xmlns=\"http://datacite.org/schema/kernel-4\" " \
                     "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" " \
                     "xsi:schemaLocation=\"http://datacite.org/schema/kernel-4
                     http://schema.datacite.org/meta/kernel-4/metadata.xsd\">" \
          "<identifier identifierType=\"DOI\">10.5438/bc123df4567</identifier>" \
          "<creators><creator><creatorName>DataCite Metadata Working Group</creatorName></creator></creators>" \
          "<titles>" \
            "<title>DataCite Metadata Schema Documentation for the Publication and Citation of Research Data v4.0" \
          "</title></titles>" \
          "<publisher>DataCite e.V.</publisher><publicationYear>2016</publicationYear>" \
          "<resourceType resourceTypeGeneral=\"Text\">Documentation</resourceType>" \
          "<relatedIdentifiers>" \
            "<relatedIdentifier relatedIdentifierType=\"URL\" relationType=\"HasMetadata\"" \
              "relatedMetadataScheme=\"citeproc+json\" " \
              "schemeURI=\"https://github.com/citation-style-language/schema/raw/master/csl-data.json\">" \
              "https://data.datacite.org/application/citeproc+json/10.5072/example-full</relatedIdentifier>" \
            "<relatedIdentifier relatedIdentifierType=\"arXiv\" relationType=\"IsReviewedBy\" " \
              "resourceTypeGeneral=\"Text\">arXiv:0706.0001</relatedIdentifier>" \
          "</relatedIdentifiers> " \
          "</resource>"
      end
      let(:attributes) do
        {
          "event" => "publish",
          "url" => "https://purl.stanford.edu/st435qh3132",
          "xml" => Base64.encode64(xml)
        }
      end

      let(:json_xml_attribute) { JSON.generate(Base64.encode64(xml)) }

      let(:request_body) do
        <<~JSON
          {"data":{"attributes":{"event":"publish","url":"https://purl.stanford.edu/st435qh3132","xml":#{json_xml_attribute}}}}
        JSON
      end

      let(:status) { 200 }
      let(:response) do
        nil
      end

      it "can update the DOI" do
        expect { generate }.not_to raise_error JsonSchema::AggregateError
      end
    end
  end

  describe "#exists?" do
    subject(:result) { client.exists?(id: "10.5438/bc123df4567") }

    before do
      stub_request(:head, "https://api.test.datacite.org/dois/10.5438/bc123df4567")
        .with(headers: {
                "Authorization" => "Basic Zm9vOmJhcg=="
              })
        .to_return(status: status)
    end

    let(:status) { 200 }

    context "when the DOI exists" do
      it "returns true" do
        expect(result.value!).to be true
      end
    end

    context "when the DOI does not exists" do
      let(:status) { 404 }

      it "returns false" do
        expect(result.value!).to be false
      end
    end

    context "when the request is unsuccessful" do
      let(:status) { 500 }

      it "returns a failure" do
        expect(result).to be_failure
      end
    end

    context "when no username or password provided" do
      subject(:client) { described_class.new }

      before do
        stub_request(:head, "https://api.test.datacite.org/dois/10.5438/bc123df4567")
          .to_return(status: status).with { |request| request.headers["Authorization"].nil? }
      end

      it 'does not include the "Authorization" header' do
        expect(result.value!).to be true
      end
    end
  end
end
