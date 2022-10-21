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

  describe 'POST /institution' do
    let(:institution_params) do
      { name: 'UNITEST', cnpj: '123456789', type_of: 'universidade' }
    end
    context 'when the request is valid' do
      before { post '/api/v1/institutions', params: institution_params }
      it 'creates an institution' do
        expect(json['name']).to eq('UNITEST')
        expect(json['cnpj']).to eq('123456789')
        expect(json['type_of']).to eq('universidade')
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when name is invalid' do
      before { institution_params.merge!(name: '') }
      before { post '/api/v1/institutions', params: institution_params }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation error message' do
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when name already exists' do
      before { post '/api/v1/institutions', params: institution_params }
      before { institution_params.merge!(cnpj: '111999') }
      before { post '/api/v1/institutions', params: institution_params }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validadtion error message' do
        expect(response.body).to include('has already been taken')
      end
    end

    context 'when cnpj is invalid' do
      before { institution_params.merge!(cnpj: 'onetwothree') }
      before { post '/api/v1/institutions', params: institution_params }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation error message' do
        expect(response.body).to include('is not a number')
      end
    end

    context 'when type_of is invalid' do
      before { institution_params.merge!(type_of: 'esola') }
      it 'raises an error' do
        expect { post '/api/v1/institutions', params: institution_params }.to raise_error(ArgumentError)
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
