module Api
  module V1
    class JobCategoriesController < ApplicationController
      # TODO[Auth]: restrict create/update/destroy to admin
      # TODO[Pagination]: add page/per_page support
      # TODO[Search]: filter by name query param
      # TODO[Response]: standardize JSON (data + meta)
      skip_before_action :authenticate_user!, only: [:index, :show]

      def index
        render json: JobCategory.all
      end

      def show
        render json: JobCategory.find(params[:id])
      end

      def create
        jc = JobCategory.new(job_category_params)
        if jc.save
          render json: jc, status: :created
        else
          render json: { errors: jc.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        jc = JobCategory.find(params[:id])
        if jc.update(job_category_params)
          render json: jc
        else
          render json: { errors: jc.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        JobCategory.find(params[:id]).destroy
        head :no_content
      end

      private

      def job_category_params
        params.require(:job_category).permit(:name)
      end
    end
  end
end
