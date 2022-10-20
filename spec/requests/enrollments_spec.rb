require 'rails_helper'

RSpec.describe 'Enrollments', type: :request do
  let!(:enrollments) { create_list(:enrollment, 5) }
  let(:enrollment_id) { enrollments.first.id }
  let(:student_id) { enrollments.first['student_id'] }
  let(:institution_id) { enrollments.first['institution_id'] }

  describe 'GET /enrollments' do
    before { get '/api/v1/enrollments' }
    it 'returns enrollments' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /enrollments/:id' do
    before { get "/api/v1/enrollments/#{enrollment_id}" }

    context 'when the enrollment exists' do
      it 'returns the enrollment' do
        expect(json['id']).to eq(enrollment_id)
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the enrollment does not exist' do
      let(:enrollment_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Enrollment with 'id'=0")
      end
    end
  end

  describe 'GET /student/:id/enrollments' do
    before { get "/api/v1/students/#{student_id}/enrollments" }
    it 'returns the student enrollments' do
      expect(json.first['student_id']).to eq(student_id)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /institutions/:id/enrollments' do
    before { get "/api/v1/institutions/#{institution_id}/enrollments" }
    it 'returns the institution enrollments' do
      expect(json.first['institution_id']).to eq(institution_id)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /enrollment' do
    let(:institution) { create(:institution) }
    let(:student) { create(:student) }
    let(:enrollment_params) do
      { institution_id:, student_id:, course_name: 'Física', total_value: 9000.00, total_invoices: 60, due_day: 15 }
    end

    context 'when the request params are valid' do
      before { post '/api/v1/enrollments', params: enrollment_params }
      it 'creates an enrollment' do
        expect(json['institution_id']).to eq(institution_id)
        expect(json['student_id']).to eq(student_id)
        expect(json['course_name']).to eq('Física')
        expect(json['total_value']).to eq('9000.0')
        expect(json['total_invoices']).to eq(60)
        expect(json['due_day']).to eq(15)
      end
      it 'when successfully created' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request params are invalid' do
      before { post '/api/v1/enrollments', params: {} }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns an error message' do
        expect(response.body).to include('must exist')
      end
    end
  end

  describe 'DELETE /enrollments/:id' do
    before { delete "/api/v1/enrollments/#{enrollment_id}" }
    it 'returns status code 204 if deleted' do
      expect(response).to have_http_status(204)
    end
  end
end
