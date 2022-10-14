require 'rails_helper'

RSpec.describe 'Students', type: :request do
  let!(:students) { create_list(:student, 5) }
  let(:student_id) { students.first.id }

  describe 'GET /students' do
    before { get '/api/v1/students' }
    it 'returns students' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /institution' do
    let(:student_params) do
      { name: 'Teste da Silva', cpf: '123456789', birth_date: '1970-07-23', phone: '99222227777', gender: 'M', payment_method: 'boleto' }
    end
    context 'when the request is valid' do
      before { post '/api/v1/students', params: student_params }
      it 'creates a student' do
        expect(json['name']).to eq('Teste da Silva')
        expect(json['cpf']).to eq('123456789')
        expect(json['birth_date']).to eq('1970-07-23')
        expect(json['phone']).to eq('99222227777')
        expect(json['gender']).to eq('M')
        expect(json['payment_method']).to eq('boleto')
      end
      it 'when successfully created' do
        expect(response).to have_http_status(201)
      end
    end
    
  end
end
