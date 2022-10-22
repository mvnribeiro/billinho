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

  describe 'GET /students/:id' do
    before { get "/api/v1/students/#{student_id}" }

    context 'when the student exists' do
      it 'returns the user' do
        expect(json['id']).to eq(student_id)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the student does not exist' do
      let(:student_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Student with 'id'=0")
      end
    end
  end

  describe 'POST /student' do
    let(:student_params) do
      { name: 'Tester da Silva', cpf: 88855544411, birth_date: '1970-07-23', phone: '99222227777', gender: 'M', payment_method: 'boleto' }
    end

    context 'when the request is valid' do
      before do
        post '/api/v1/students', params: { student: student_params }
      end
      it 'creates a student' do
        expect(json['cpf']).to eq('88855544411')
        expect(json['name']).to eq('Tester da Silva')
        expect(json['birth_date']).to eq('1970-07-23')
        expect(json['phone']).to eq('99222227777')
        expect(json['gender']).to eq('M')
        expect(json['payment_method']).to eq('boleto')
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request attributes are invalid' do
      before do
        post '/api/v1/students', params: { student: { name: '' } }
      end
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns an error message' do
        expect(response.body).to include("can't be blank")
      end
    end
  end

  describe 'DELETE /students/:id' do
    before { delete "/api/v1/students/#{student_id}" }
    it 'returns status code 204 if deleted' do
      expect(response).to have_http_status(204)
    end
  end
end
