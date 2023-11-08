class Balance < ApplicationRecord
  belongs_to :user

  validates :withdrawn, :balance_deposited, :current_balance, presence: true
  validates :withdrawn, :balance_deposited, :current_balance, numericality: { greater_than_or_equal_to: 0 }
  validates :user, presence: true

  scope :positive_balance, -> { where("current_balance > 0") }
  scope :by_user, ->(user) { where(user: user) }

  after_save :calculate_current_balance

  def calculate_current_balance
    self.current_balance = current_balance - withdrawn
  end

  def withdraw(amount)
    self.current_balance ||= 0.0
    self.current_balance -= amount
    self.withdrawn ||= 0.0
    self.withdrawn += amount
    save!
  end

  def deposit(amount)
    self.current_balance ||= 0.0
    self.current_balance += amount
    self.balance_deposited ||= 0.0
    self.balance_deposited += amount
    save!
  end
end
