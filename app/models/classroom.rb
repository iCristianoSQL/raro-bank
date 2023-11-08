class Classroom < ApplicationRecord
  has_many :administrators
  has_many :users

  validates :name, presence: true
end
