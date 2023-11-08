class EndOfTermJob < ApplicationJob
  queue_as :default

  def perform
    investments = Investment.includes(:product).where(redeemed: false, products: { end_of_term: Date.today })

    investments.each do |investment|
      user_balance = investment.user.balance.current_balance
      value_to_redeem = investment.invested_amount
      investment.user.balance.update!(current_balance: user_balance + value_to_redeem)
      investment.update!(redeemed: true)
    end
  end
end