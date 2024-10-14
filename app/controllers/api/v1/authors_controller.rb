# frozen_string_literal: true

module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :set_author, only: %i[show update destroy]

      # GET /authors
      def index
        authors = Author.all

        render json: { authors: AuthorSerializer.many(authors) }
      end

      # GET /authors/1
      def show
        render json: AuthorSerializer.one(@author)
      end

      # POST /authors
      def create
        author = Author.new(author_params)

        if author.save
          render json: AuthorSerializer.one(author), status: :created
        else
          render json: { errors: author.errors }, status: :unprocessable_entity
        end
      end

      # PUT /authors/1
      def update
        if @author.update(author_params)
          render json: AuthorSerializer.one(@author)
        else
          render json: { errors: @author.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /authors/1
      def destroy
        result = Authors::Destroy.new(author: @author).call

        return unless result.failure?

        render json: { errors: result.failure }, status: :unprocessable_entity
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_author
        @author = Author.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def author_params
        params.require(:author).permit(:first_name, :last_name)
      end
    end
  end
end
