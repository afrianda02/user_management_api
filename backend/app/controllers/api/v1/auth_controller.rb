module Api
  module V1
    class AuthController < ApplicationController
      skip_before_action :authenticate_user!, only: [:register, :login, :refresh]

      def register
        user = User.new(register_params)
        if user.save
          tokens = issue_tokens(user)
          render json: { user: user_payload(user), **tokens }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        user = User.active.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          tokens = issue_tokens(user)
          render json: { user: user_payload(user), **tokens }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def refresh
        raw = params[:refresh_token]
        rt = RefreshToken.active.find_each.detect { |t| t.matches?(raw) }
        if rt && !rt.expired? && !rt.revoked?
          rt.revoke!
          tokens = issue_tokens(rt.user)
          render json: tokens
        else
          render json: { error: "Invalid refresh token" }, status: :unauthorized
        end
      end

      def logout
        current_user&.refresh_tokens.active.each(&:revoke!)
        render json: { message: "Logged out" }
      end

      def me
        render json: { user: user_payload(current_user) }
      end

      private

      def register_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

      def issue_tokens(user)
        access = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
        raw_refresh = SecureRandom.urlsafe_base64(64)
        RefreshToken.create!(
          user: user,
          token_digest: BCrypt::Password.create(raw_refresh),
          expires_at: 7.days.from_now
        )
        { access_token: access, refresh_token: raw_refresh, token_type: "Bearer" }
      end

      def user_payload(user)
        { id: user.id, name: user.name, email: user.email, role: user.role }
      end
    end
  end
end