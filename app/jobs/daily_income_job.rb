class DailyIncomeJob < ApplicationJob
  queue_as :default

  def perform
    Investment.where(redeemed: false).each do |investment|
      fee_value = investment.product.fee.value
      additional_fee = investment.product.additional_fee / 365
      final_fee = additional_fee + fee_value
      performance = investment.invested_amount * (final_fee / 100)
      new_invested_amount = investment.invested_amount + performance
      puts "passei aqui!"
      investment.update_column(:invested_amount, new_invested_amount)
    end
  end
end
