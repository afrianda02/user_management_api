class JobCategory < ApplicationRecord
  # TODO[Validation]: add description, active flag, icon
  # TODO[Search]: add scope for name search
  validates :name, presence: true, uniqueness: true
end
