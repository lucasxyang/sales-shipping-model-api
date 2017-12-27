# spec/requests/documents_spec.rb
require 'rails_helper'

RSpec.describe 'Documents API' do
  # Initialize the test data
  let!(:customer) { create(:customer) }
  let!(:documents) { create_list(:document, 20, customer_id: customer.id) }
  let(:customer_id) { customer.id }
  let(:id) { documents.first.id }

  # Test suite for GET /customers/:customer_id/documents
  describe 'GET /customers/:customer_id/documents' do
    before { get "/customers/#{customer_id}/documents" }

    context 'when customer exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all customer documents' do
        expect(json.size).to eq(20)
      end
    end

    context 'when customer does not exist' do
      let(:customer_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end
  
=begin
  # Test suite for GET /customers/:customer_id/documents/:id
  describe 'GET /customers/:customer_id/documents/:id' do
    before { get "/customers/#{customer_id}/documents/#{id}" }

    context 'when customer document exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the document' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when customer document does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Document/)
      end
    end
  end
=end

end