class RefreshToken < ApplicationRecord
  belongs_to :user

  validates :token_digest, presence: true, uniqueness: true

  scope :active, -> { where(revoked_at: nil).where("expires_at > ?", Time.current) }

  def self.digest(raw)
    BCrypt::Password.create(raw)
  end

  def matches?(raw)
    BCrypt::Password.new(token_digest) == raw
  end

  def revoke!
    update!(revoked_at: Time.current)
  end

  def expired?
    expires_at <= Time.current
  end

  def revoked?
    revoked_at.present?
  end
end