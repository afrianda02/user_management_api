module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        users = User.active.order(created_at: :desc)
        pagy, records = pagy(users, items: params.fetch(:per_page, 20).to_i)
        render json: {
          data: records.map { |u| user_payload(u) },
          meta: { page: pagy.page, pages: pagy.pages, count: pagy.count }
        }
      end

      def show
        render json: { user: user_payload(@user) }
      end

      def update
        if @user.update(update_params)
          render json: { user: user_payload(@user) }
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.soft_delete!
        head :no_content
      end

      private

      def set_user
        @user = User.active.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Not found" }, status: :not_found
      end

      def update_params
        params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
      end

      def user_payload(user)
        { id: user.id, name: user.name, email: user.email, role: user.role, created_at: user.created_at }
      end
    end
  end
end