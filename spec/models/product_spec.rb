require 'rails_helper'

RSpec.describe Product do
  let(:fee) { Fee.create(name: "Test Fee") }

  describe "validations" do
    it "is valid with valid attributes" do
      product = Product.new(name: "Test Product", end_of_term: Date.today, premium: true, additional_fee: 10, minimum_investment_amount: 100, fee: fee)
      expect(product).to be_valid
    end

    it "is not valid without a name" do
      product = Product.new(end_of_term: Date.today, premium: true, additional_fee: 10, minimum_investment_amount: 100, fee: fee)
      expect(product).to_not be_valid
    end

    it "is not valid with a name less than 4 characters" do
      product = Product.new(name: "Tes", end_of_term: Date.today, premium: true, additional_fee: 10, minimum_investment_amount: 100, fee: fee)
      expect(product).to_not be_valid
    end

    it "is not valid with a name more than 100 characters" do
      product = Product.new(name: "a" * 101, end_of_term: Date.today, premium: true, additional_fee: 10, minimum_investment_amount: 100, fee: fee)
      expect(product).to_not be_valid
    end

    it "is not valid without an end_of_term date" do
      product = Product.new(name: "Test Product", premium: true, additional_fee: 10, minimum_investment_amount: 100, fee: fee)
      expect(product).to_not be_valid
    end

    it "is not valid without a premium value" do
      product = Product.new(name: "Test Product", end_of_term: Date.today, premium: nil, additional_fee: 10, minimum_investment_amount: 100, fee: fee)
      expect(product).to_not be_valid
    end

    it "is not valid without an additional_fee value" do
      product = Product.new(name: "Test Product", end_of_term: Date.today, premium: true, minimum_investment_amount: 100, fee: fee)
      expect(product).to_not be_valid
    end

    it "is not valid without a minimum_investment_amount value" do
      product = Product.new(name: "Test Product", end_of_term: Date.today, premium: true, additional_fee: 10, fee: fee)
      expect(product).to_not be_valid
    end

    it "is not valid without a fee" do
      product = Product.new(name: "Test Product", end_of_term: Date.today, premium: true, additional_fee: 10, minimum_investment_amount: 100)
      expect(product).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a fee" do
      association = described_class.reflect_on_association(:fee)
      expect(association.macro).to eq :belongs_to
    end
  end
end
