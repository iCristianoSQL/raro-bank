require 'rails_helper'

describe Balance do
  describe 'validations' do
    it { should validate_presence_of(:withdrawn) }
    it { should validate_presence_of(:balance_deposited) }
    it { should validate_presence_of(:current_balance) }
    it { should validate_numericality_of(:withdrawn).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:balance_deposited).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:current_balance).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:user) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe '.positive_balance' do
    it 'returns balances with positive current balance' do
      create(:balance, withdrawn: 20, balance_deposited: 70, current_balance: 50)
      create(:balance, withdrawn: 50, balance_deposited: 30, current_balance: 20)
      create(:balance, withdrawn: 0, balance_deposited: 0, current_balance: 0)
      create(:balance, withdrawn: 0, balance_deposited: 100, current_balance: 100)

      balances = Balance.positive_balance

      expect(balances.count).to eq(3)
      expect(balances.pluck(:current_balance)).to all(be_positive)
    end
  end

  describe 'callbacks' do
    describe '#calculate_current_balance' do
      it 'calculates the current balance correctly' do
        balance = create(:balance, balance_deposited: 100, withdrawn: 25)
        expect(balance.current_balance).to eq(75)
      end
    end
  end
end
