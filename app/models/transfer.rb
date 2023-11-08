class Transfer < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  enum status: {
    pending: 1,
    confirmed: 2
  }

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :sender, presence: true
  validate :sufficient_balance, if: :sender
  validate :token_not_expired

  before_create :generate_token
  before_create :set_expiration

  def execute_transfer
    sender_balance = sender.balance || Balance.new(user: sender)
    receiver_balance = receiver.balance || Balance.new(user: receiver)

    Transfer.transaction do
      sender_balance.withdraw(amount)
      receiver_balance.deposit(amount)
    end
  end

  def token_expired?
    expires_at.present? && expires_at < Time.current
  end

  private

  def generate_token
    self.token = rand(100000..999999)
  end

  def set_expiration
    self.expires_at = 1.minute.from_now
  end

  def sufficient_balance
    sender_balance = sender.balance || Balance.new(user: sender)
    if amount > sender_balance.current_balance
      errors.add(:amount, "Saldo insuficiente para realizar a transferência.")
    end
  end

  def token_not_expired
    if self.token.present? && token_expired?
      errors.add(:base, "Token expirado!")
    end
  end
end
