# frozen_string_literal: true

module Api
  module V1
    class CompetenciesController < ApplicationController
      before_action :set_competency, only: %i[show update destroy]

      # GET /competencies
      def index
        competencies = Competency.includes(course: :author)

        render json: { competencies: CompetencySerializer.many(competencies) }
      end

      # GET /competencies/1
      def show
        render json: CompetencySerializer.one(@competency)
      end

      # POST /competencies
      def create
        competency = Competency.new(competency_params)

        if competency.save
          render json: CompetencySerializer.one(competency), status: :created
        else
          render json: { errors: competency.errors }, status: :unprocessable_entity
        end
      end

      # PUT /competencies/1
      def update
        if @competency.update(competency_params)
          render json: CompetencySerializer.one(@competency)
        else
          render json: { errors: @competency.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /competencies/1
      def destroy
        @competency.destroy
      end

      private

      def set_competency
        @competency = Competency.find(params[:id])
      end

      def competency_params
        params.require(:competency).permit(:name, :course_id)
      end
    end
  end
end
