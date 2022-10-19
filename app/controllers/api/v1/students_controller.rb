module Api
  module V1
    class StudentsController < ApplicationController
      before_action :set_student, only: %i[show destroy]

      # GET /students
      def index
        @students = Student.all
        render json: StudentsRepresenter.new(@students).as_json
      end

      # POST /student
      def create
        @student = Student.create(student_params)
        if @student.save
          render json: StudentRepresenter.new(@student).as_json, status: :created
        else
          render json: @student.errors, status: :unprocessable_entity
        end
      end

      # GET /students/:id
      def show
        render json: StudentRepresenter.new(@student).as_json
      end

      # DELETE /student/:id
      def destroy
        @student.destroy
        head :no_content
      end

      private

      def student_params
        params.permit(:name, :cpf, :birth_date, :phone, :gender, :payment_method)
      end

      def set_student
        @student = Student.find(params[:id])
      end
    end
  end
end
