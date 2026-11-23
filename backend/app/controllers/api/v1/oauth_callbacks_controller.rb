module Api
  module V1
    class OauthCallbacksController < ApplicationController
      skip_before_action :authenticate_user!, only: [:create, :failure]

      def create
        auth = request.env["omniauth.auth"]
        user = User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |u|
          u.email = auth.info.email
          u.name = auth.info.name || auth.info.nickname
          u.password = Devise.friendly_token[0, 20]
        end
        tokens = issue_tokens(user)
        render json: { user: { id: user.id, name: user.name, email: user.email }, **tokens }
      end

      def failure
        render json: { error: "OAuth authentication failed" }, status: :unauthorized
      end

      private

      def issue_tokens(user)
        access = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
        raw_refresh = SecureRandom.urlsafe_base64(64)
        RefreshToken.create!(user: user, token_digest: BCrypt::Password.create(raw_refresh), expires_at: 7.days.from_now)
        { access_token: access, refresh_token: raw_refresh, token_type: "Bearer" }
      end
    end
  end
end