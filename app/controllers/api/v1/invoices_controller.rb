module Api
  module V1
    class InvoicesController < ApplicationController
      before_action :set_invoice, only: %i[show destroy]

      # GET /invoices
      def index
        @invoices = Invoice.all
        render json: InvoicesRepresenter.new(@invoices).as_json
      end
      
      def show
        render json: InvoiceRepresenter.new(@invoice).as_json
      end

      # # POST /invoice
      # def create
      #   @invoice = Invoice.create(invoice_params)
      #   if @invoice.save
      #     render json: InvoiceRepresenter.new(@invoice).as_json, status: :created
      #   else
      #     render json: @invoice.errors, status: :unprocessable_entity
      #   end
      # end

      # GET /students/:id/invoices
      def by_student
        @student_id = params[:student_id]
        @invoices = Invoice.where(student_id: @student_id)
        render json: InvoicesRepresenter.new(@invoices).as_json
      end

      # GET /institutions/:id/invoices
      def by_institution
        @institution_id = params[:institution_id]
        @invoices = Invoice.where(institution_id: @institution_id)
        render json: InvoicesRepresenter.new(@invoices).as_json
      end

      # DELETE /invoices/:id
      def destroy
        @invoice.destroy
        head :no_content
      end

      private

      def invoice_params
        params.permit(:enrollment, :enrollment_id, :institution_id, :student_id, :value, :due_date, :status)
      end

      def set_invoice
        @invoice = Invoice.find(params[:id])
      end
    end
  end
end
