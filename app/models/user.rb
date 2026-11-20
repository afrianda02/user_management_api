require "devise"
require "devise/orm/active_record"
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, :omniauthable, jwt_revocation_strategy: JwtDenylist,
         omniauth_providers: [:google_oauth2, :github]

  has_many :refresh_tokens, dependent: :destroy

  enum :role, { user: 0, admin: 1 }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  scope :active, -> { where(deleted_at: nil) }

  def soft_delete!
    update!(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end

  def jwt_payload
    { "role" => role }
  end
end