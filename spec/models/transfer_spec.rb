require 'rails_helper'

RSpec.describe Transfer do
  let(:sender) { User.create(name: "John") }
  let(:receiver) { User.create(name: "Jane") }

  describe "associations" do
    it { should belong_to(:sender).class_name("User") }
    it { should belong_to(:receiver).class_name("User") }
  end

  describe "validations" do
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end
end
