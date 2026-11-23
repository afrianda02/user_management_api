FactoryBot.define do
  factory :refresh_token do
    user
    token_digest { BCrypt::Password.create(SecureRandom.urlsafe_base64(64)) }
    expires_at { 7.days.from_now }
  end
end