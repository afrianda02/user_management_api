class JobCategory < ApplicationRecord
  # TODO: add more validations/fields (description, active flag)
  validates :name, presence: true, uniqueness: true
end
