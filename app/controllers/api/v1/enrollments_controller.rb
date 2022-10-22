module Api
  module V1
    class EnrollmentsController < ApplicationController
      # before_action :set_student, only: %i[show destroy]
      # before_action :set_institution, only: %i[show destroy]
      before_action :set_enrollment, only: %i[show destroy]

      # GET /enrollments
      def index
        @enrollments = Enrollment.all
        render json: EnrollmentsRepresenter.new(@enrollments).as_json
      end

      def show
        render json: EnrollmentRepresenter.new(@enrollment).as_json
      end

      # POST /enrollment
      def create
        @enrollment = Enrollment.create(enrollment_params)
        if @enrollment.save
          InvoiceGenerator.call(@enrollment)
          render json: EnrollmentRepresenter.new(@enrollment).as_json, status: :created
        else
          render json: @enrollment.errors, status: :unprocessable_entity
        end
      end

      # GET /students/:id/enrollments
      def by_student
        @student_id = params[:student_id]
        @enrollments = Enrollment.where(student_id: @student_id)
        render json: EnrollmentsRepresenter.new(@enrollments).as_json
      end

      # GET /institutions/:id/enrollments
      def by_institution
        @institution_id = params[:institution_id]
        @enrollments = Enrollment.where(institution_id: @institution_id)
        render json: EnrollmentsRepresenter.new(@enrollments).as_json
      end

      def destroy
        @enrollment.destroy
        head :no_content
      end

      private

      def enrollment_params
        params.require(:enrollment).permit(:institution_id, :student_id, :course_name, :total_value, :total_invoices, :due_day)
      end

      def set_enrollment
        @enrollment = Enrollment.find(params[:id])
      end
    end
  end
end
