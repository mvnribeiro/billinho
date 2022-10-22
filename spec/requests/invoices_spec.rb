require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  let!(:invoice) { create(:invoice) }
  let!(:invoice_id) { invoice['id'] }
  let!(:enrollment_id) { invoice['enrollment_id'] }
  let!(:student_id) { invoice['student_id'] }
  let!(:institution_id) { invoice['institution_id'] }

  describe 'GET /invoices' do
    before { get '/api/v1/invoices' }
    it 'returns enrollments' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /invoices/:id' do
    before { get "/api/v1/invoices/#{invoice_id}" }

    context 'when the invoice exists' do
      it 'returns the invoice' do
        expect(json['id']).to eq(invoice_id)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the invoice does not exist' do
      let(:invoice_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Invoice with 'id'=0")
      end
    end
  end

  describe 'GET /student/:id/invoices' do
    before { get "/api/v1/students/#{student_id}/invoices" }
    it 'returns the student enrollments' do
      expect(json[0]['student_id']).to eq(student_id)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /institution/:id/invoices' do
    before { get "/api/v1/institutions/#{institution_id}/invoices" }
    it 'returns the institution enrollments' do
      expect(json[0]['institution_id']).to eq(institution_id)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /invoices/:id' do
    before { delete "/api/v1/invoices/#{invoice_id}" }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
