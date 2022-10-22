# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Institutions', type: :request do
  let!(:institutions) { create_list(:institution, 3) }
  let(:institution_id) { institutions.first.id }

  describe 'GET /institutions' do
    before { get '/api/v1/institutions' }
    it 'returns institutions' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /institutions/:id' do
    before { get "/api/v1/institutions/#{institution_id}" }

    context 'when the institution exists' do
      it 'returns the institution' do
        expect(json['id']).to eq(institution_id)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the institution does not exist' do
      let(:institution_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Institution with 'id'=0")
      end
    end
  end

  describe 'POST /institution' do
    let(:institution_params) do
      { name: 'UNITEST', cnpj: '123456789', type_of: 'universidade' }
    end
    context 'when the request is valid' do
      before do
        post '/api/v1/institutions', params: { institution: institution_params }
      end
      it 'creates an institution' do
        expect(json['name']).to eq('UNITEST')
        expect(json['cnpj']).to eq('123456789')
        expect(json['type_of']).to eq('universidade')
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request params are invalid' do
      before do
        post '/api/v1/institutions', params: { institution: { name: '' } }
      end
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns an error message' do
        expect(response.body).to include("can't be blank")
      end
    end
  end

  describe 'DELETE /institutions/:id' do
    before { delete "/api/v1/institutions/#{institution_id}" }
    it 'returns status code 204 if deleted' do
      expect(response).to have_http_status(204)
    end
  end
end
