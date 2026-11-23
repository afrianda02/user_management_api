class ApplicationController < ActionController::API
  include Pundit::Authorization
  include Pagy::Backend

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  private

  def forbidden
    render json: { error: "Forbidden" }, status: :forbidden
  end
end