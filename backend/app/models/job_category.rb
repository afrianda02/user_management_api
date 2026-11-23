class JobCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
