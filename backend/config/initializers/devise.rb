Devise.setup do |config|
  config.mailer_sender = "no-reply@example.com"
  config.jwt do |jwt|
    jwt.secret = ENV.fetch("JWT_SECRET_KEY")
    jwt.dispatch_requests = [["POST", %r{^/api/v1/auth/login$}], ["POST", %r{^/api/v1/auth/register$}]]
    jwt.revocation_requests = [["DELETE", %r{^/api/v1/auth/logout$}]]
    jwt.expiration_time = 15.minutes.to_i
  end
end