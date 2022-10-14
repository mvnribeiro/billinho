module Api
  module V1
    class InstitutionsController < ApplicationController
      before_action :set_institution, only: %i[show destroy]
      # GET /institutions
      def index 
        @institutions = Institution.all
        render json: InstitutionsRepresenter.new(@institutions).as_json
      end

      #POST /institution
      def create
        @institution = Institution.create(institution_params)
        if @institution.save
          render json: InstitutionRepresenter.new(@institution).as_json, status: :created
        else
          render json: @institution.errors, status: :unprocessable_entity
        end
      end

      # GET /institutions/:id
      def show
        render json: InstitutionRepresenter.new(@institution).as_json
      end

      #DELETE /institution/:id
      def destroy
        @institution.destroy
        head :no_content
      end

      private
      def institution_params
        params.permit(:name, :cnpj, :type_of)
      end
      def set_institution
        @institution = Institution.find(params[:id])
      end
    
    end
  end
end
