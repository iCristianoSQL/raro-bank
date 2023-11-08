class Product < ApplicationRecord
    belongs_to :fee
    
    validates :name, presence: true, uniqueness: true, length: { minimum: 4, maximum: 100 }
    validates :end_of_term, presence: true
    validates :premium, inclusion: { in: [true, false] }
    validates :additional_fee, presence: true
    validates :minimum_investment_amount, presence: true
    validates :fee, presence: true
  end