class Fee < ApplicationRecord
  has_many :products
  
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :value, presence: true, inclusion: { in: 0..100, message: "Deve estar entre 0 e 1000" }
  validates :latest_release, presence: true
end
