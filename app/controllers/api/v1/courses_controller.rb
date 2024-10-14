# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: %i[show update destroy]

      # GET /courses
      def index
        courses = Course.includes(:author)

        render json: { courses: CourseSerializer.many(courses) }
      end

      # GET /courses/1
      def show
        render json: CourseSerializer.one(@course)
      end

      # POST /courses
      def create
        course = Course.new(course_params)

        if course.save
          render json: CourseSerializer.one(course), status: :created
        else
          render json: { errors: course.errors }, status: :unprocessable_entity
        end
      end

      # PUT /courses/1
      def update
        if @course.update(course_params)
          render json: CourseSerializer.one(@course)
        else
          render json: { errors: @course.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /courses/1
      def destroy
        @course.destroy
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end

      def course_params
        params.require(:course).permit(:name, :author_id)
      end
    end
  end
end
