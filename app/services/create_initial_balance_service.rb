class CreateInitialBalanceService
  def self.call(user)
    balance = Balance.new
    balance.withdrawn = 0
    balance.current_balance = 0
    balance.balance_deposited = 0
    balance.user = user
    balance.save
  end
end
